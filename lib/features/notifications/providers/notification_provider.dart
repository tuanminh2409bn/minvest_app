// lib/features/notifications/providers/notification_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/notifications/models/notification_model.dart';
import 'package:minvest_forex_app/features/notifications/services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  StreamSubscription? _notificationsSubscription;
  StreamSubscription? _unreadCountSubscription;

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;

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

  @override
  void dispose() {
    _notificationsSubscription?.cancel();
    _unreadCountSubscription?.cancel();
    super.dispose();
  }
}