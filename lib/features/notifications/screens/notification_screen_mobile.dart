// lib/features/notifications/screens/notification_screen_mobile.dart

import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart'; // THÊM IMPORT
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/notifications/models/notification_model.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().markAllAsRead();
    });
  }

  void _onNotificationTap(NotificationModel notification) async {
    if (notification.signalId == null) return;

    final signal = await SignalService().getSignalById(notification.signalId!);
    final userTier = context.read<UserProvider>().userTier ?? 'free';

    if (signal != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignalDetailScreen(
            signal: signal,
            userTier: userTier,
          ),
        ),
      );
    }
  }

  static const Map<String, String> _currencyFlags = {
    'AUD': 'assets/images/aud_flag.png',
    'CHF': 'assets/images/chf_flag.png',
    'EUR': 'assets/images/eur_flag.png',
    'GBP': 'assets/images/gbp_flag.png',
    'JPY': 'assets/images/jpy_flag.png',
    'NZD': 'assets/images/nzd_flag.png',
    'USD': 'assets/images/us_flag.png',
    'XAU': 'assets/images/crown_icon.png',
  };

  String? _extractSymbolFromTitle(String title) {
    final RegExp regex = RegExp(r'\b([A-Z]{3}\/[A-Z]{3}|XAU\/USD)\b');
    final Match? match = regex.firstMatch(title.toUpperCase());
    return match?.group(0);
  }

  List<String> _getFlagPathsFromSymbol(String? symbol) {
    if (symbol == null) return [];
    final parts = symbol.toUpperCase().split('/');
    if (parts.length == 2) {
      final path1 = _currencyFlags[parts[0]];
      final path2 = _currencyFlags[parts[1]];
      return [
        if (path1 != null) path1,
        if (path2 != null) path2,
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Lấy mã ngôn ngữ hiện tại từ provider
    final langCode = context.watch<LanguageProvider>().locale?.languageCode ?? 'vi';

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: Text(l10n.notifications, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.notifications.isEmpty) {
            return Center(
              child: Text(
                l10n.noNotificationsYet,
                style: const TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              final timeAgo = _formatTimestamp(notification.timestamp, l10n);

              return ListTile(
                onTap: () => _onNotificationTap(notification),
                leading: _buildLeadingIcon(notification),
                // --- THAY ĐỔI 1: SỬ DỤNG HÀM getTitle() ---
                title: Text(
                  notification.getTitle(langCode),
                  style: TextStyle(
                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // --- THAY ĐỔI 2: SỬ DỤNG HÀM getBody() ---
                subtitle: Text(
                  '${notification.getBody(langCode)}\n$timeAgo',
                  style: TextStyle(
                    color: notification.isRead ? Colors.grey.shade500 : Colors.grey.shade300,
                  ),
                ),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLeadingIcon(NotificationModel notification) {
    // --- THAY ĐỔI 3: Lấy symbol từ title tiếng Anh để đảm bảo nhất quán ---
    final symbol = _extractSymbolFromTitle(notification.getTitle('en'));
    final flagPaths = _getFlagPathsFromSymbol(symbol);

    if (flagPaths.isNotEmpty) {
      return SizedBox(
        width: 42,
        height: 28,
        child: Stack(
          children: List.generate(flagPaths.length, (index) {
            return Positioned(
              left: index * 14.0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFF161B22),
                backgroundImage: AssetImage(flagPaths[index]),
              ),
            );
          }),
        ),
      );
    }
    return CircleAvatar(
      backgroundColor: notification.isRead
          ? Colors.blueGrey.withOpacity(0.3)
          : const Color(0xFF5865F2),
      child: _getIconForType(notification.type),
    );
  }

  Icon _getIconForType(String type) {
    // ... không có thay đổi ở đây ...
    switch (type) {
      case 'new_signal':
        return const Icon(Icons.new_releases, color: Colors.white, size: 20);
      case 'signal_matched':
        return const Icon(Icons.check_circle_outline, color: Colors.white, size: 20);
      case 'tp1_hit':
      case 'tp2_hit':
      case 'tp3_hit':
        return const Icon(Icons.flag_circle_outlined, color: Colors.white, size: 20);
      case 'sl_hit':
        return const Icon(Icons.cancel_outlined, color: Colors.white, size: 20);
      default:
        return const Icon(Icons.notifications, color: Colors.white, size: 20);
    }
  }

  String _formatTimestamp(Timestamp timestamp, AppLocalizations l10n) {
    // ... không có thay đổi ở đây ...
    final DateTime date = timestamp.toDate();
    final Duration diff = DateTime.now().difference(date);
    if (diff.inDays > 1) {
      return l10n.daysAgo(diff.inDays);
    } else if (diff.inHours > 0) {
      return l10n.hoursAgo(diff.inHours);
    } else if (diff.inMinutes > 0) {
      return l10n.minutesAgo(diff.inMinutes);
    } else {
      return l10n.justNow;
    }
  }
}