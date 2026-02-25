// lib/app/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/app/main_screen.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/intro_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/main.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isSessionResetDialogShowing = false;
  bool _hasRedirectedToLanding = false;

  void _showErrorDialog(BuildContext context, String message) {
    if (!mounted) return;
    final displayMessage = message.startsWith('Exception: ') ? message.substring(11) : message;
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

  void _showSessionResetDialog(BuildContext context, UserProvider userProvider) {
    if (_isSessionResetDialogShowing || !mounted) return;

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
        if (!mounted) return;
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
        // Nếu đang trong quá trình đăng xuất, hiển thị màn hình chờ đơn giản
        if (state.status == AuthStatus.loggingOut) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator(color: Color(0xFF276EFB))),
          );
        }

        // Nếu đã xác thực
        if (state.status == AuthStatus.authenticated) {
          return Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.requiresSessionReset) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showSessionResetDialog(context, userProvider);
                });
              }

              if (kIsWeb) {
                if (!_hasRedirectedToLanding) {
                  _hasRedirectedToLanding = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacementNamed('/');
                  });
                }
                return const Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // Mobile Authenticated
              return MainScreen(key: mainScreenKey);
            },
          );
        }

        // Mặc định: Chưa đăng nhập
        return const IntroScreen();
      },
    );
  }
}