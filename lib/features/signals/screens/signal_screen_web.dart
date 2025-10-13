// lib/features/signals/screens/signal_screen_web.dart

import 'package:flutter/material.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/signals/models/signal_model.dart';
import 'package:minvest_forex_app/features/signals/services/signal_service.dart';
import 'package:minvest_forex_app/features/signals/widgets/signal_card.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
import 'package:minvest_forex_app/features/notifications/screens/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class SignalScreen extends StatefulWidget {
  const SignalScreen({super.key});

  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  bool _isLive = true;
  final SignalService _signalService = SignalService();

  bool _isWithinGoldenHours() {
    final nowInVietnam = DateTime.now().toUtc().add(const Duration(hours: 7));
    return nowInVietnam.hour >= 8 && nowInVietnam.hour < 17;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userTier = userProvider.userTier ?? 'free';
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    _buildTabs(l10n),
                    const SizedBox(width: 40),
                    _buildFilters(l10n),
                    const Spacer(),
                    // ▼▼▼ BẮT ĐẦU SỬA ĐỔI ▼▼▼
                    const _LanguageSwitcher(), // Luôn hiển thị lá cờ
                    const SizedBox(width: 16),
                    // Chỉ hiển thị chuông thông báo cho user đã đăng nhập
                    if (userTier != 'free')
                      Consumer<NotificationProvider>(
                        builder: (context, notificationProvider, child) {
                          final bool hasUnread = notificationProvider.unreadCount > 0;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_none, size: 28),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const NotificationScreen()),
                                  );
                                },
                              ),
                              if (hasUnread)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    height: 9,
                                    width: 9,
                                    decoration: const BoxDecoration(
                                        color: Colors.redAccent,
                                        shape: BoxShape.circle,
                                        border: Border.fromBorderSide(BorderSide(color: Color(0xFF0D1117), width: 1.5))
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    // ▲▲▲ KẾT THÚC SỬA ĐỔI ▲▲▲
                  ],
                ),
              ),
              Expanded(
                child: _buildContent(userTier, l10n),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Các hàm còn lại giữ nguyên không thay đổi)
  Widget _buildContent(String userTier, AppLocalizations l10n) {
    if (userTier == 'free') {
      return _buildFreeUserView(l10n);
    }
    if (_isLive && (userTier == 'vip' || userTier == 'demo') && !_isWithinGoldenHours()) {
      return _buildOutOfHoursView(userTier, l10n);
    }
    return _buildSignalList(userTier, l10n);
  }

  Widget _buildFreeUserView(AppLocalizations l10n) {
    final dummySignal1 = Signal(
      id: 'dummy1', symbol: 'XAU/USD', type: 'Buy', status: 'running',
      createdAt: Timestamp.now(), entryPrice: 0, stopLoss: 0, takeProfits: [], isMatched: false, matchStatus: 'NOT MATCHED',
    );
    final dummySignal2 = Signal(
      id: 'dummy2', symbol: 'EUR/USD', type: 'Sell', status: 'running',
      createdAt: Timestamp.now(), entryPrice: 0, stopLoss: 0, takeProfits: [], isMatched: false, matchStatus: 'NOT MATCHED',
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              SignalCard(signal: dummySignal1, userTier: 'free', isLocked: true),
              SignalCard(signal: dummySignal2, userTier: 'free', isLocked: true),
              const SizedBox(height: 20),
              _buildUpgradeButton(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignalList(String userTier, AppLocalizations l10n) {
    return StreamBuilder<List<Signal>>(
      stream: _signalService.getSignals(isLive: _isLive, userTier: userTier),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('${l10n.error}: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text(l10n.noSignalsAvailable));
        }

        final signals = snapshot.data!;
        int itemCount = signals.length;
        bool Function(int) isLockedCallback;

        switch (userTier) {
          case 'demo':
            if (_isLive && signals.length > 8) {
              itemCount = 9;
            }
            isLockedCallback = (index) => _isLive && index >= 8;
            break;
          default:
            isLockedCallback = (index) => false;
            break;
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (userTier == 'demo' && _isLive && index == 8) {
                  return _buildUpgradeButton(l10n);
                }
                final signal = signals[index];
                final bool isLocked = isLockedCallback(index);
                return SignalCard(
                  signal: signal,
                  userTier: userTier,
                  isLocked: isLocked,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilters(AppLocalizations l10n) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _GradientFilterButton(text: l10n.symbol, onPressed: () {}),
        const SizedBox(width: 20),
        _GradientFilterButton(text: l10n.aiSignal, onPressed: () {}),
      ],
    );
  }

  Widget _buildOutOfHoursView(String userTier, AppLocalizations l10n) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer_off_outlined, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 20),
              Text(
                l10n.outOfGoldenHours,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                userTier == 'vip' ? l10n.outOfGoldenHoursVipDesc : l10n.outOfGoldenHoursDemoDesc,
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _buildUpgradeButton(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradeButton(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeScreen())),
          style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)], stops: [0.0, 0.5, 1.0], begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/crown_icon.png', height: 24, width: 24),
                  const SizedBox(width: 8),
                  Text(l10n.upgradeAccount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF161B22), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 80, height: 32, child: _buildTabItem(l10n.live, _isLive, () => setState(() => _isLive = true))),
          SizedBox(width: 80, height: 32, child: _buildTabItem(l10n.end, !_isLive, () => setState(() => _isLive = false))),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(colors: [Color(0xFF172AFE), Color(0xFF3C4BFE), Color(0xFF5E69FD)], begin: Alignment.centerLeft, end: Alignment.centerRight) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
      ),
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  const _LanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    return PopupMenuButton<Locale>(
      onSelected: (Locale locale) => languageProvider.setLocale(locale),
      itemBuilder: (context) => [
        const PopupMenuItem(value: Locale('en'), child: Text('English')),
        const PopupMenuItem(value: Locale('vi'), child: Text('Tiếng Việt')),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, provider, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              provider.locale?.languageCode == 'vi'
                  ? 'assets/images/vn_flag.png'
                  : 'assets/images/us_flag.png',
              height: 24,
              width: 36,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class _GradientFilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _GradientFilterButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120),
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blueGrey.withOpacity(0.5)),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: const TextStyle(fontSize: 11)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}