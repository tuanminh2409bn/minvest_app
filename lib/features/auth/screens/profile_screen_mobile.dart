// lib/features/auth/screens/profile_screen_mobile.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/admin/screens/admin_panel_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:minvest_forex_app/features/auth/screens/settings_screen.dart';

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
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, 0.78),
                    end: const Alignment(1.00, 0.20),
                    colors: [
                      const Color(0xFF1E1E1E).withValues(alpha: 0.4),
                      const Color(0xFF0D0D0D).withValues(alpha: 0.2)
                    ],
                  ),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
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
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Select up to 4 Apps for Profile',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: allApps.length,
                          itemBuilder: (context, index) {
                            final app = allApps[index];
                            final isSelected = selectedAppNames.contains(app.name);
                            return _buildAppOptionTile(
                              app: app,
                              isSelected: isSelected,
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

  Widget _buildAppOptionTile({
    required ExchangeApp app,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? const Color(0xFF276EFB) : Colors.white10),
        ),
        child: Row(
          children: [
            Image.asset(app.iconPath, width: 32, height: 32),
            const SizedBox(width: 16),
            Text(app.name, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const Spacer(),
            Icon(
              isSelected ? Icons.check_circle : Icons.add_circle_outline,
              color: isSelected ? const Color(0xFF276EFB) : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    final userTier = userProvider.userTier ?? 'free';
    final tokenBalance = userProvider.tokenBalance;
    final userEmail = currentUser?.email ?? 'user@gmail.com';

    // Get selected app objects
    final displayApps = allApps.where((app) => selectedAppNames.contains(app.name)).take(4).toList();

    return Scaffold(
      backgroundColor: Colors.black,
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
                  height: 512,
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
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 24),
                    child: Text(
                      'Accounts',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),

                  // Token Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      height: 168,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(
                            userTier.toLowerCase() == 'elite' || userTier.toLowerCase() == 'vip'
                                ? (userProvider.subscriptionExpiryDate != null && 
                                   userProvider.subscriptionExpiryDate!.difference(DateTime.now()).inDays > 40
                                    ? 'assets/mockups/year.png' 
                                    : 'assets/mockups/month.png')
                                : 'assets/mockups/free.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            top: 21,
                            child: Text(userEmail, style: const TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                          Positioned(
                            left: 16,
                            top: 84,
                            child: const Text('Your Tokens', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
                          ),
                          Positioned(
                            left: 16,
                            top: 112,
                            child: Text(
                              userTier.toLowerCase() == 'elite' ? 'Unlimited' : '$tokenBalance left',
                              style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Exchange Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Access The Exchange', style: TextStyle(color: Color(0xFF686868), fontSize: 16)),
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

                  const SizedBox(height: 80),

                  // Menu Items
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        _buildMenuButton(
                          label: 'Upgrade To Pro',
                          icon: Icons.workspace_premium_outlined,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradeScreen())),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuButton(
                          label: 'Settings',
                          icon: Icons.settings_outlined,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuButton(
                          label: 'Online Support',
                          icon: Icons.support_agent_outlined,
                          onTap: () => _launchURL('https://zalo.me/0969156969'),
                        ),
                        const SizedBox(height: 8),
                        _buildMenuButton(label: 'Payment History', icon: Icons.history_outlined, onTap: () {}),
                        const SizedBox(height: 8),
                        if (userProvider.role == 'admin')
                          _buildMenuButton(
                            label: 'Admin Panel',
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
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, 1.00),
            end: const Alignment(1.00, 0.12),
            colors: [const Color(0xFF1E1E1E).withValues(alpha: 0.9), const Color(0xFF0D0D0D).withValues(alpha: 0.6)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.white.withValues(alpha: 0.1)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 24),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
