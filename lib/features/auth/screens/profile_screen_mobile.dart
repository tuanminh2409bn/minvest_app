// lib/features/auth/screens/profile_screen_mobile.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/admin/screens/admin_panel_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
import 'package:minvest_forex_app/features/notifications/screens/notification_screen.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minvest_forex_app/features/auth/screens/settings_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/payment_history/screens/payment_history_screen.dart';
import 'package:minvest_forex_app/features/affiliate/screens/affiliate_dashboard_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ExchangeApp {
  final String name;
  final String iconPath;
  final String url;

  ExchangeApp({required this.name, required this.iconPath, required this.url});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ExchangeApp> allApps = [
    ExchangeApp(name: 'Exness', iconPath: 'assets/icons/exness.png', url: 'https://my.exmarkets.guide/accounts/sign-up/303589?utm_source=partners&ex_ol=1'),
    ExchangeApp(name: 'BingX', iconPath: 'assets/icons/bingx.png', url: 'https://bingx.com/invite/S6UV9A'),
    ExchangeApp(name: 'OKX', iconPath: 'assets/icons/okx.png', url: 'https://www.okx.com/join/minvest'),
    ExchangeApp(name: 'Binance', iconPath: 'assets/icons/binance.png', url: 'https://www.binance.com/vi/register?ref=12345678'),
    ExchangeApp(name: 'ByBit', iconPath: 'assets/icons/bybit.png', url: 'https://www.bybit.com/invite?ref=MINVEST'),
    ExchangeApp(name: 'Bitget', iconPath: 'assets/icons/bitget.png', url: 'https://www.bitget.com/expressly?languageType=0&channelCode=minvest&vipCode=minvest'),
    ExchangeApp(name: 'MEXC', iconPath: 'assets/icons/mexc.png', url: 'https://www.mexc.com/register?inviteCode=mexc-MINVEST'),
    ExchangeApp(name: 'MT4', iconPath: 'assets/icons/mt4.png', url: 'https://metatrader4.com'),
    ExchangeApp(name: 'MT5', iconPath: 'assets/icons/mt5.png', url: 'https://metatrader5.com'),
  ];

  List<String> selectedAppNames = ['Exness', 'BingX', 'OKX', 'Binance'];

  @override
  void initState() {
    super.initState();
    _loadSelectedApps();
  }

  Future<void> _loadSelectedApps() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('selected_exchange_apps');
    if (saved != null && saved.isNotEmpty) {
      setState(() {
        selectedAppNames = saved;
      });
    }
  }

  Future<void> _saveSelectedApps() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_exchange_apps', selectedAppNames);
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  void _showAppSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.04),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20), // Removed title text
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: allApps.length,
                          itemBuilder: (context, index) {
                            final app = allApps[index];
                            final isSelected = selectedAppNames.contains(app.name);
                            final bool isTop = index == 0;
                            final bool isBottom = index == allApps.length - 1;

                            return GestureDetector(
                              onTap: () {
                                setModalState(() {
                                  if (isSelected) {
                                    if (selectedAppNames.length > 1) {
                                      selectedAppNames.remove(app.name);
                                    }
                                  } else {
                                    if (selectedAppNames.length < 4) {
                                      selectedAppNames.add(app.name);
                                    }
                                  }
                                });
                                setState(() {}); // Update Profile Screen
                                _saveSelectedApps();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(isTop ? 12 : 0),
                                    topRight: Radius.circular(isTop ? 12 : 0),
                                    bottomLeft: Radius.circular(isBottom ? 12 : 0),
                                    bottomRight: Radius.circular(isBottom ? 12 : 0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(app.iconPath, width: 32, height: 32),
                                    const SizedBox(width: 16),
                                    Text(
                                      app.name, 
                                      style: const TextStyle(
                                        color: Colors.white, 
                                        fontSize: 18,
                                        fontFamily: 'Be Vietnam Pro',
                                        fontWeight: FontWeight.w400,
                                      )
                                    ),
                                    const Spacer(),
                                    Icon(
                                      isSelected ? Icons.check_circle : Icons.add_circle_outline,
                                      color: isSelected ? const Color(0xFF276EFB) : Colors.white10, // Subtle unselected icon
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    final userTier = userProvider.userTier?.toLowerCase() ?? 'free';
    final tokenBalance = userProvider.tokenBalance;
    final userEmail = userProvider.email ?? currentUser?.email ?? 'user@gmail.com';
    final l10n = AppLocalizations.of(context)!;

    // Helper logic to determine the correct card image
    String getCardImage() {
      if (userTier == 'elite' || userTier == 'vip') {
        final expiryDate = userProvider.subscriptionExpiryDate;
        if (expiryDate != null) {
          final daysLeft = expiryDate.difference(DateTime.now()).inDays;
          // Logic: Yearly plans usually have > 300 days, 
          // but we check > 45 days to safely identify extended plans.
          if (daysLeft > 45) return 'assets/mockups/year.png';
        }
        return 'assets/mockups/month.png';
      } else if (userTier == 'demo') {
        return 'assets/mockups/month.png'; // Show month card for demo users
      }
      return 'assets/mockups/free.png';
    }

    // Get selected app objects
    final displayApps = allApps.where((app) => selectedAppNames.contains(app.name)).take(4).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
        title: Text(
          l10n.accounts,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              final bool hasUnread = notificationProvider.unreadCount > 0;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none, size: 28, color: Colors.white),
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
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Header Glass Background
              Positioned(
                left: -1,
                top: -81,
                child: Container(
                  width: MediaQuery.of(context).size.width + 2,
                  height: 450,
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 0.96, color: Colors.white10),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),

              Column(
                children: [
                  const SizedBox(height: 16),

                  // Token Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(getCardImage()),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 18,
                            top: 18,
                            child: Text(
                              userEmail, 
                              style: const TextStyle(
                                color: Colors.white, 
                                fontSize: 14, 
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Be Vietnam Pro',
                              )
                            ),
                          ),
                          Positioned(
                            left: 18,
                            bottom: 52,
                            child: Text(
                              l10n.yourTokens, 
                              style: const TextStyle(
                                color: Colors.white, 
                                fontSize: 18, 
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Be Vietnam Pro',
                              )
                            ),
                          ),
                          Positioned(
                            left: 18,
                            bottom: 14,
                            child: Text(
                              userTier == 'elite' ? l10n.unlimited : '$tokenBalance ${l10n.left}',
                              style: const TextStyle(
                                color: Colors.white, 
                                fontSize: 32, 
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Be Vietnam Pro',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Exchange Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.accessExchange, style: const TextStyle(color: Color(0xFF686868), fontSize: 16)),
                            GestureDetector(
                              onTap: () => _showAppSelection(context),
                              child: Container(
                                width: 20,
                                height: 21,
                                decoration: BoxDecoration(color: const Color(0xFF161616), borderRadius: BorderRadius.circular(6)),
                                child: const Icon(Icons.chevron_right, size: 14, color: Colors.white54),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: displayApps.map((app) => _buildExchangeIcon(app.name, app.iconPath, app.url)).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Menu Items
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        _buildMenuButton(
                          label: l10n.upgradeToPro,
                          icon: Icons.workspace_premium_outlined,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeScreen())),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuButton(
                          label: l10n.setting,
                          icon: Icons.settings_outlined,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuButton(
                          label: l10n.onlineSupport,
                          icon: Icons.support_agent_outlined,
                          onTap: () => _launchURL('https://www.tidio.com/talk/4z2xqtu7ftageaykiq3k7b6vcb55cotv'),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuButton(
                          label: l10n.paymentHistory, 
                          icon: Icons.history_outlined, 
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentHistoryScreen())),
                        ),
                        const SizedBox(height: 8),
                        if (userProvider.userRole == 'affiliate' || userProvider.userRole == 'admin')
                          _buildMenuButton(
                            label: l10n.affiliateDashboard,
                            icon: Icons.people_outline,
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AffiliateDashboardScreen())),
                          ),
                        const SizedBox(height: 8),
                        if (userProvider.role == 'admin')
                          _buildMenuButton(
                            label: l10n.adminPanel,
                            icon: Icons.admin_panel_settings_outlined,
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPanelScreen())),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 140),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExchangeIcon(String name, String iconPath, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Column(
        children: [
          Container(
            width: 59,
            height: 50,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, 1.00),
                end: const Alignment(1.00, 0.12),
                colors: [Colors.white.withValues(alpha: 0.15), Colors.white.withValues(alpha: 0.05)],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.white.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Center(
              child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMenuButton({required String label, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-1.0, -2.0),
            end: const Alignment(1.0, 2.0),
            colors: [
              Colors.white.withValues(alpha: 0.6),
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.8),
            ],
            stops: const [0.0, 0.07, 0.88, 1.0],
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(1), // Border width
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Be Vietnam Pro',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.white54, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
