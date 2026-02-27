import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceService {
  // Singleton pattern
  static final PriceService _instance = PriceService._internal();
  factory PriceService() => _instance;
  PriceService._internal();

  WebSocketChannel? _binanceChannel;
  StreamSubscription? _binanceSubscription;
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

  // Các host Binance ổn định
  final List<String> _binanceHosts = [
    'stream.binance.com:443',
    'stream.binance.com:9443',
    'data-stream.binance.com',
    'stream.binance.vision',
  ];
  int _binanceHostIndex = 0;

  bool _isConnecting = false;

  void connect() {
    _isDisposed = false;
    _cleanup();
    _connectBinance();
  }

  // Kết nối duy nhất tới Binance cho tất cả các cặp tiền
  void _connectBinance() {
    if (_isDisposed || _isConnecting) return;
    
    _isConnecting = true;
    final host = _binanceHosts[_binanceHostIndex % _binanceHosts.length];
    final url = Uri.parse('wss://$host/stream?streams=btcusdt@ticker/ethusdt@ticker/paxgusdt@ticker');
    
    debugPrint('🌐 Connecting to Binance Price Stream: $host');

    try {
      _binanceChannel = IOWebSocketChannel.connect(
        url,
        connectTimeout: const Duration(seconds: 5),
      );
      
      _binanceSubscription = _binanceChannel!.stream.listen(
        (message) {
          _isConnecting = false;
          try {
            final data = jsonDecode(message);
            final streamName = data['stream'];
            final payload = data['data'];
            final price = double.tryParse(payload['c']?.toString() ?? '0') ?? 0.0;

            if (streamName == 'btcusdt@ticker') {
              _currentPrices['BTC'] = price;
            } else if (streamName == 'ethusdt@ticker') {
              _currentPrices['ETH'] = price;
            } else if (streamName == 'paxgusdt@ticker') {
              _currentPrices['XAU'] = price;
            }
            _notifyListeners();
          } catch (e) {
            // Silence parsing errors
          }
        },
        onError: (e) {
          _isConnecting = false;
          debugPrint('❌ Binance WS Error ($host): Connection failed (Network issue)');
          _rotateHost();
          _reconnect();
        },
        onDone: () {
          _isConnecting = false;
          debugPrint('ℹ️ Binance WS Closed ($host)');
          _reconnect();
        },
        cancelOnError: true,
      );
    } catch (e) {
      _isConnecting = false;
      debugPrint('❌ Binance Connect Exception: $e');
      _rotateHost();
      _reconnect();
    }
  }

  void _rotateHost() {
    _binanceHostIndex++;
  }

  void _notifyListeners() {
    if (!_priceController.isClosed && !_isDisposed) {
      _priceController.add(Map.from(_currentPrices));
    }
  }

  void _reconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 10), () {
      if (!_isDisposed) _connectBinance();
    });
  }

  void _cleanup() {
    _binanceSubscription?.cancel();
    _binanceChannel?.sink.close();
    _binanceChannel = null;
    _binanceSubscription = null;
    _reconnectTimer?.cancel();
  }

  void disconnect() {
    _cleanup();
  }
}
