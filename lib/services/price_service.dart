import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class PriceService {
  // Singleton pattern
  static final PriceService _instance = PriceService._internal();
  factory PriceService() => _instance;
  PriceService._internal();

  // APISed Config (for XAUUSD)
  static const String _apisedKey = "sk_c27869e90912e2A4f32E104A77Ad9dFC02bb47B5e489f4cE";
  static const String _apisedUrl = "https://gold.g.apised.com/v1/latest?metals=XAU&base_currency=USD&currencies=USD&weight_unit=TOZ";

  // TradingView WS Config (for BTC, ETH)
  static const String _tvWsUrl = "wss://data.tradingview.com/socket.io/websocket";
  static const Map<String, String> _tvHeaders = {
    "Origin": "https://data.tradingview.com",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
  };

  WebSocketChannel? _tvChannel;
  StreamSubscription? _tvSubscription;
  Timer? _apisedTimer;
  Timer? _reconnectTimer;
  bool _isDisposed = false;

  final StreamController<Map<String, double>> _priceController =
      StreamController<Map<String, double>>.broadcast();

  Stream<Map<String, double>> get priceStream => _priceController.stream;

  // Cache giá hiện tại
  final Map<String, double> _currentPrices = {
    'BTC': 0.0,
    'ETH': 0.0,
    'XAU': 0.0,
  };

  bool _isConnectingTV = false;

  void connect() {
    if (_isConnectingTV) return;
    _isDisposed = false;
    debugPrint('🚀 PriceService: Starting connection...');
    _cleanup();
    _startApisedPolling();
    _connectTradingView();
  }

  // --- APISed Logic (XAUUSD) ---
  void _startApisedPolling() {
    _apisedTimer?.cancel();
    _fetchXauPrice(); // Initial fetch
    _apisedTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_isDisposed) _fetchXauPrice();
    });
  }

  Future<void> _fetchXauPrice() async {
    try {
      final response = await http.get(
        Uri.parse(_apisedUrl),
        headers: {"x-api-key": _apisedKey},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          final priceData = data['data']['metal_prices']['XAU']['price'];
          final price = double.tryParse(priceData.toString()) ?? 0.0;
          if (price > 0 && price != _currentPrices['XAU']) {
            _currentPrices['XAU'] = price;
            _notifyListeners();
          }
        }
      }
    } catch (e) {
      // Quietly handle network errors for polling
    }
  }

  // --- TradingView WS Logic (BTC, ETH) ---
  void _connectTradingView() {
    if (_isDisposed || _isConnectingTV) return;
    
    _isConnectingTV = true;
    debugPrint('🌐 PriceService: Connecting to TradingView WS...');

    try {
      if (kIsWeb) {
        _tvChannel = WebSocketChannel.connect(Uri.parse(_tvWsUrl));
      } else {
        _tvChannel = IOWebSocketChannel.connect(
          Uri.parse(_tvWsUrl),
          headers: _tvHeaders,
          connectTimeout: const Duration(seconds: 10),
        );
      }
      
      _tvSubscription = _tvChannel!.stream.listen(
        (message) {
          _isConnectingTV = false;
          _handleTvMessage(message.toString());
        },
        onError: (e) {
          _isConnectingTV = false;
          debugPrint('❌ PriceService: TradingView WS Error: $e');
          _reconnectTV();
        },
        onDone: () {
          _isConnectingTV = false;
          debugPrint('ℹ️ PriceService: TradingView WS Stream closed');
          _reconnectTV();
        },
        cancelOnError: true,
      );

      // Gửi handshake ban đầu
      _sendTvHandshake();
    } catch (e) {
      _isConnectingTV = false;
      debugPrint('❌ PriceService: TradingView Connection failed: $e');
      _reconnectTV();
    }
  }

  void _sendTvHandshake() {
    try {
      _sendTvPacket("set_auth_token", ["unauthorized_user_token"]);
      _setupTvSymbol("cs_btc", "sds_btc", "BINANCE:BTCUSDT");
      _setupTvSymbol("cs_eth", "sds_eth", "BINANCE:ETHUSDT");
    } catch (e) {
      debugPrint('❌ PriceService: Error sending handshake: $e');
    }
  }

  void _setupTvSymbol(String chartId, String seriesId, String symbol) {
    _sendTvPacket("chart_create_session", [chartId, ""]);
    _sendTvPacket("switch_timezone", [chartId, "Etc/UTC"]);
    _sendTvPacket("resolve_symbol", [
      chartId,
      "${seriesId}_sym",
      '={"symbol":"$symbol","adjustment":"splits","session":"regular"}'
    ]);
    _sendTvPacket("create_series", [
      chartId, seriesId, "s1", "${seriesId}_sym", "1", 1, ""
    ]);
  }

  void _handleTvMessage(String raw) {
    final packets = _parseTvPackets(raw);
    for (final packet in packets) {
      if (packet.startsWith("~h~")) {
        try {
          _tvChannel?.sink.add(_packTvMsg(packet));
        } catch (e) {}
        continue;
      }
      
      try {
        final data = jsonDecode(packet);
        if (data is Map && data.containsKey('m')) {
          final m = data['m'];
          final p = data['p'];
          
          if ((m == "timescale_update" || m == "du") && p is List) {
            for (final update in p) {
              if (update is Map) {
                update.forEach((key, val) {
                  if (val is Map && val.containsKey('s')) {
                    final bars = val['s'] as List;
                    if (bars.isNotEmpty) {
                      final lastBar = bars.last;
                      if (lastBar is Map && lastBar.containsKey('v')) {
                        final v = lastBar['v'] as List;
                        if (v.length >= 5) {
                          final closePrice = double.tryParse(v[4].toString()) ?? 0.0;
                          if (closePrice > 0) {
                            if (key == "sds_btc") {
                              if (_currentPrices['BTC'] != closePrice) {
                                _currentPrices['BTC'] = closePrice;
                                _notifyListeners();
                              }
                            } else if (key == "sds_eth") {
                              if (_currentPrices['ETH'] != closePrice) {
                                _currentPrices['ETH'] = closePrice;
                                _notifyListeners();
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                });
              }
            }
          }
        }
      } catch (e) {
        // Skip malformed packets
      }
    }
  }

  List<String> _parseTvPackets(String raw) {
    final List<String> results = [];
    int pos = 0;
    while (pos < raw.length) {
      if (!raw.startsWith("~m~", pos)) break;
      
      final nextMarker = raw.indexOf("~m~", pos + 3);
      if (nextMarker == -1) break;
      
      final lengthStr = raw.substring(pos + 3, nextMarker);
      final length = int.tryParse(lengthStr);
      if (length == null) break;
      
      final start = nextMarker + 3;
      if (start + length > raw.length) break;
      
      results.add(raw.substring(start, start + length));
      pos = start + length;
    }
    return results;
  }

  void _sendTvPacket(String method, List params) {
    try {
      final msg = jsonEncode({"m": method, "p": params});
      _tvChannel?.sink.add(_packTvMsg(msg));
    } catch (e) {
      // Sink might be closed
    }
  }

  String _packTvMsg(String msg) {
    return "~m~${msg.length}~m~$msg";
  }

  void _reconnectTV() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    // Tăng thời gian chờ lên 15 giây để tránh spam log khi mất mạng
    _reconnectTimer = Timer(const Duration(seconds: 15), () {
      if (!_isDisposed) _connectTradingView();
    });
  }

  void _notifyListeners() {
    if (!_priceController.isClosed && !_isDisposed) {
      _priceController.add(Map.from(_currentPrices));
    }
  }

  void _cleanup() {
    _apisedTimer?.cancel();
    _tvSubscription?.cancel();
    try {
      _tvChannel?.sink.close();
    } catch (e) {}
    _tvChannel = null;
    _tvSubscription = null;
    _reconnectTimer?.cancel();
    _isConnectingTV = false;
  }

  void disconnect() {
    debugPrint('🛑 PriceService: Disconnecting...');
    _isDisposed = true;
    _cleanup();
  }
}
