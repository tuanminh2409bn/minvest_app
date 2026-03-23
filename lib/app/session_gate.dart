// lib/app/session_gate.dart
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/core/utils/navigator_key.dart';
import 'package:provider/provider.dart';

class SessionGate extends StatefulWidget {
  final Widget child;
  const SessionGate({super.key, required this.child});

  @override
  State<SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<SessionGate> {
  bool _isSessionResetDialogShowing = false;

  void _showSessionResetDialog(BuildContext context, UserProvider userProvider) {
    if (_isSessionResetDialogShowing || !mounted) return;

    // Sử dụng navigatorKey để lấy context có Navigator
    final navigatorContext = navigatorKey.currentContext;
    if (navigatorContext == null) return;

    setState(() {
      _isSessionResetDialogShowing = true;
    });

    showDialog(
      context: navigatorContext,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Thông báo quan trọng'),
          content: Text(userProvider.sessionResetReason ?? 'Tài khoản của bạn có sự thay đổi. Vui lòng đăng nhập lại.'),
          actions: [
            TextButton(
              onPressed: () async {
                await userProvider.acknowledgeSessionReset();
                if (mounted) {
                  Navigator.of(dialogContext).pop();
                  setState(() {
                    _isSessionResetDialogShowing = false;
                  });
                  // Kích hoạt đăng xuất sau khi người dùng đã xác nhận
                  context.read<AuthBloc>().add(SignOutRequested(
                    providersToReset: [
                      userProvider,
                      context.read<NotificationProvider>(),
                    ],
                  ));
                }
              },
              child: const Text('Tôi đã hiểu'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.requiresSessionReset) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showSessionResetDialog(context, userProvider);
          });
        }
        return widget.child;
      },
    );
  }
}
