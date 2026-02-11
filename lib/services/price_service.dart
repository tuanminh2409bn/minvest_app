import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PriceService {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
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

  void connect() {
    if (_isDisposed) return;

    // Hủy các kết nối và subscription cũ nếu có
    _cleanup();

    final url = Uri.parse(
        'wss://stream.binance.com:9443/stream?streams=btcusdt@trade/ethusdt@trade/paxgusdt@trade');
    
    try {
      _channel = WebSocketChannel.connect(url);
      _subscription = _channel!.stream.listen(
        (message) {
          if (_isDisposed || _priceController.isClosed) return;

          final data = jsonDecode(message);
          final streamName = data['stream'];
          final payload = data['data'];
          final price = double.tryParse(payload['p']) ?? 0.0;

          if (streamName == 'btcusdt@trade') {
            _currentPrices['BTC'] = price;
          } else if (streamName == 'ethusdt@trade') {
            _currentPrices['ETH'] = price;
          } else if (streamName == 'paxgusdt@trade') {
            _currentPrices['XAU'] = price;
          }

          if (!_priceController.isClosed) {
            _priceController.add(Map.from(_currentPrices));
          }
        },
        onError: (error) {
          debugPrint('WebSocket Error: $error');
          _reconnect();
        },
        onDone: () {
          debugPrint('WebSocket Closed');
          _reconnect();
        },
      );
    } catch (e) {
      debugPrint('WebSocket Connect Error: $e');
      _reconnect();
    }
  }

  void _reconnect() {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connect();
    });
  }

  void _cleanup() {
    _subscription?.cancel();
    _subscription = null;
    _channel?.sink.close();
    _channel = null;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void disconnect() {
    _isDisposed = true;
    _cleanup();
    if (!_priceController.isClosed) {
      _priceController.close();
    }
  }
}
