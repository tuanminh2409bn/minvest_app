// lib/features/notifications/providers/notification_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:minvest_forex_app/features/notifications/models/notification_model.dart';
import 'package:minvest_forex_app/features/notifications/services/notification_service.dart' as feat_service;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationProvider with ChangeNotifier {
  final feat_service.NotificationService _notificationService = feat_service.NotificationService();

  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  StreamSubscription? _notificationsSubscription;
  StreamSubscription? _unreadCountSubscription;

  // Settings
  bool _isAllEnabled = true;
  bool _isGoldEnabled = true;
  bool _isCryptoEnabled = true;
  bool _isForexEnabled = true;

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  bool get isAllEnabled => _isAllEnabled;
  bool get isGoldEnabled => _isGoldEnabled;
  bool get isCryptoEnabled => _isCryptoEnabled;
  bool get isForexEnabled => _isForexEnabled;

  NotificationProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isAllEnabled = prefs.getBool('notif_all') ?? true;
    _isGoldEnabled = prefs.getBool('notif_gold') ?? true;
    _isCryptoEnabled = prefs.getBool('notif_crypto') ?? true;
    _isForexEnabled = prefs.getBool('notif_forex') ?? true;
    notifyListeners();
  }

  Future<void> toggleAll(bool value) async {
    _isAllEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_all', value);
    
    if (!kIsWeb) {
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic('all_signals');
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic('all_signals');
      }
    }
    notifyListeners();
  }

  Future<void> toggleGold(bool value) async {
    _isGoldEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_gold', value);
    
    if (!kIsWeb) {
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic('gold_signals');
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic('gold_signals');
      }
    }
    notifyListeners();
  }

  Future<void> toggleCrypto(bool value) async {
    _isCryptoEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_crypto', value);
    
    if (!kIsWeb) {
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic('crypto_signals');
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic('crypto_signals');
      }
    }
    notifyListeners();
  }

  Future<void> toggleForex(bool value) async {
    _isForexEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_forex', value);
    
    if (!kIsWeb) {
      if (value) {
        await FirebaseMessaging.instance.subscribeToTopic('forex_signals');
      } else {
        await FirebaseMessaging.instance.unsubscribeFromTopic('forex_signals');
      }
    }
    notifyListeners();
  }

  // 1. Xóa hàm khởi tạo cũ để provider không tự động lắng nghe nữa
  // NotificationProvider() {
  //   _listenToNotifications();
  // }

  // 2. Đổi tên hàm private `_listenToNotifications` thành public `startListening`
  //    AuthGate sẽ gọi hàm này khi đăng nhập thành công.
  void startListening() {
    // Hủy các listener cũ nếu có
    _notificationsSubscription?.cancel();
    _unreadCountSubscription?.cancel();

    // Logic lắng nghe gốc của bạn được giữ nguyên
    _notificationsSubscription = _notificationService.getNotifications().listen((notificationsList) {
      _notifications = notificationsList;
      notifyListeners();
    });

    _unreadCountSubscription = _notificationService.getUnreadNotificationCount().listen((count) {
      _unreadCount = count;
      notifyListeners();
    });
  }

  // 3. Tạo hàm mới để dừng lắng nghe và dọn dẹp
  //    AuthBloc sẽ gọi hàm này trước khi đăng xuất
  Future<void> stopListeningAndReset() async {
    await _notificationsSubscription?.cancel();
    await _unreadCountSubscription?.cancel();
    _notificationsSubscription = null;
    _unreadCountSubscription = null;
    _notifications = [];
    _unreadCount = 0;
    notifyListeners();
  }

  // Hàm gốc của bạn được đổi tên cho nhất quán
  Future<void> markAllAsRead() async {
    await _notificationService.markAllAsRead();
  }

  // Đánh dấu 1 thông báo là đã đọc
  Future<void> markAsRead(String notificationId) async {
    await _notificationService.markAsRead(notificationId);
  }

  @override
  void dispose() {
    _notificationsSubscription?.cancel();
    _unreadCountSubscription?.cancel();
    super.dispose();
  }
}