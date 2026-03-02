// lib/features/notifications/screens/notification_screen_mobile.dart

import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart'; // THÊM IMPORT
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/notifications/models/notification_model.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/screens/signal_analyze_screen.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
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

    final userProvider = context.read<UserProvider>();
    final userTier = userProvider.userTier?.toLowerCase() ?? 'free';
    final isFree = userTier != 'elite' && userTier != 'vip';

    if (isFree && notification.type.contains('signal')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UpgradeScreen()),
      );
      return;
    }

    final signal = await SignalService().getSignalById(notification.signalId!);

    if (signal != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignalAnalyzeScreen(
            signal: signal,
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
    final langCode = context.watch<LanguageProvider>().locale?.languageCode ?? 'vi';
    final userProvider = context.watch<UserProvider>();
    final userTier = userProvider.userTier?.toLowerCase() ?? 'free';
    final isFree = userTier != 'elite' && userTier != 'vip';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          l10n.notifications, 
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Be Vietnam Pro',
            fontWeight: FontWeight.w500,
          )
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.notifications.isEmpty) {
            return Center(
              child: Text(
                l10n.noNotificationsYet,
                style: const TextStyle(color: Colors.grey, fontFamily: 'Be Vietnam Pro'),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40),
            itemCount: provider.notifications.length + (isFree ? 1 : 0),
            itemBuilder: (context, index) {
              if (isFree && index == provider.notifications.length) {
                return _buildUpgradeBanner(context, l10n);
              }

              final notification = provider.notifications[index];
              final timeAgo = _formatTimestamp(notification.timestamp, l10n);
              
              String title = notification.getTitle(langCode);
              String body = notification.getBody(langCode);

              // If user is free and it's a signal notification, use generic text
              if (isFree && notification.type.contains('signal')) {
                title = l10n.newSignalUploaded;
                final symbol = _extractSymbolFromTitle(notification.getTitle('en')) ?? 'XAUUSD';
                body = l10n.newSymbolSignalUploaded(symbol.replaceAll('/', ''));
              }

              return GestureDetector(
                onTap: () => _onNotificationTap(notification),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  decoration: BoxDecoration(
                    color: notification.isRead ? Colors.transparent : const Color(0xFF212121),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Be Vietnam Pro',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.90,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        body,
                        style: const TextStyle(
                          color: Color(0xFF797979),
                          fontSize: 16,
                          fontFamily: 'Be Vietnam Pro',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.80,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        timeAgo,
                        style: const TextStyle(
                          color: Color(0xFF9A9A9A),
                          fontSize: 12,
                          fontFamily: 'Be Vietnam Pro',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.60,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildUpgradeBanner(BuildContext context, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      height: 174,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0.00, 1.00),
          end: const Alignment(1.09, -0.05),
          colors: [
            Colors.white.withValues(alpha: 0.15),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.white.withValues(alpha: 0.20),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x4C797979),
            blurRadius: 6,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.upgradeToViewSignalBanner,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Be Vietnam Pro',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const UpgradeScreen())
              );
            },
            child: Container(
              width: 142,
              height: 37,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.00, 0.50),
                  end: Alignment(1.00, 0.50),
                  colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              alignment: Alignment.center,
              child: Text(
                l10n.upgradeNow,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
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