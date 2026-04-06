// lib/app/permission_gate.dart
//
// Widget này là màn hình đầu tiên sau khi runApp().
// ATT đã được xử lý trong main() TRƯỚC runApp().
// PermissionGate chỉ chịu trách nhiệm khởi tạo tuần tự các dịch vụ
// cần BuildContext (Provider), và xin quyền thông báo (Notification).
//
// THỨ TỰ:
//   [main()]   1. ATT ← đã xong trước khi widget này xuất hiện
//   [PermissionGate] 2. AuthService.initialize()
//   [PermissionGate] 3. PurchaseService.initialize()
//   [PermissionGate] 4. NotificationService.initialize() ← xin quyền thông báo
//   [PermissionGate] 5. Hiển thị AuthGate

import 'package:flutter/material.dart';
import 'package:minvest_forex_app/app/auth_gate.dart';
import 'package:minvest_forex_app/core/services/purchase_service.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import 'package:minvest_forex_app/services/notification_service.dart';
import 'package:provider/provider.dart';

class PermissionGate extends StatefulWidget {
  /// Callback được gọi khi user nhấn vào một push notification.
  final Future<void> Function(Map<String, dynamic>) onNotificationTapped;

  const PermissionGate({
    super.key,
    required this.onNotificationTapped,
  });

  @override
  State<PermissionGate> createState() => _PermissionGateState();
}

class _PermissionGateState extends State<PermissionGate> {
  bool _initDone = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _runSequentialInit();
    });
  }

  /// Khởi tạo tuần tự các dịch vụ cần context.
  /// ATT đã được xử lý trong main() trước bước này.
  Future<void> _runSequentialInit() async {
    // ── BƯỚC 2: AuthService ──────────────────────────────────────────────────
    if (!mounted) return;
    await context.read<AuthService>().initialize();

    // ── BƯỚC 3: PurchaseService ──────────────────────────────────────────────
    if (!mounted) return;
    context.read<PurchaseService>().initialize();
    debugPrint('✅ [INIT] PurchaseService đã khởi tạo.');

    // ── BƯỚC 4: NotificationService ──────────────────────────────────────────
    // Xin quyền thông báo sau ATT (ATT đã xong ở main()).
    await NotificationService().initialize(
      onNotificationTapped: widget.onNotificationTapped,
    );
    final fcmToken = await NotificationService().getFcmToken();
    if (fcmToken != null) {
      debugPrint('FCM Token: $fcmToken');
    }

    // ── BƯỚC 5: Chuyển sang AuthGate ─────────────────────────────────────────
    if (mounted) {
      setState(() => _initDone = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initDone) {
      return const Scaffold(
        backgroundColor: Color(0xFF121212),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF276EFB),
            strokeWidth: 2.5,
          ),
        ),
      );
    }
    return const AuthGate();
  }
}
