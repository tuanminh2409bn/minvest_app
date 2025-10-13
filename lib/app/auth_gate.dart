// lib/app/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/app/main_screen.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/welcome_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  // --- THAY ĐỔI 1: Đổi tên biến cờ cho tổng quát ---
  bool _isSessionResetDialogShowing = false;

  void _showErrorDialog(BuildContext context, String message) {
    final displayMessage =
    message.startsWith('Exception: ') ? message.substring(11) : message;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(displayMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // --- THAY ĐỔI 2: Cập nhật hàm hiển thị dialog ---
  void _showSessionResetDialog(BuildContext context, UserProvider userProvider) {
    if (_isSessionResetDialogShowing) return;

    setState(() {
      _isSessionResetDialogShowing = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Thông báo quan trọng'),
          // Sử dụng lý do từ sessionResetReason
          content: Text(userProvider.sessionResetReason ??
              'Tài khoản của bạn có sự thay đổi. Vui lòng đăng nhập lại.'),
          actions: [
            TextButton(
              onPressed: () async {
                // Gọi hàm mới để xóa cờ hiệu trên Firestore
                await userProvider.acknowledgeSessionReset();
                if (mounted) {
                  Navigator.of(dialogContext).pop();
                  setState(() {
                    _isSessionResetDialogShowing = false;
                  });
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        final notificationProvider = context.read<NotificationProvider>();

        if (state.status == AuthStatus.authenticated) {
          notificationProvider.startListening();
        } else if (state.status == AuthStatus.unauthenticated) {
          notificationProvider.stopListeningAndReset();
          if (state.errorMessage != null) {
            _showErrorDialog(context, state.errorMessage!);
          }
        }
      },
      builder: (context, state) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // --- THAY ĐỔI 3: Lắng nghe cờ hiệu mới ---
              if (userProvider.requiresSessionReset &&
                  state.status == AuthStatus.authenticated &&
                  mounted) {
                // Gọi hàm hiển thị dialog mới
                _showSessionResetDialog(context, userProvider);
              }
            });

            if (state.status == AuthStatus.authenticated) {
              return const MainScreen();
            } else if (state.status == AuthStatus.loggingOut) {
              return const Scaffold(
                backgroundColor: Color(0xFF0D1117),
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const WelcomeScreen();
            }
          },
        );
      },
    );
  }
}