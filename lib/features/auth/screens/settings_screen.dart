import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/features/auth/screens/change_password_screen.dart';
import 'package:minvest_forex_app/features/auth/screens/notification_settings_screen.dart';
import 'package:minvest_forex_app/features/auth/screens/terms_of_use_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/app/widgets/liquid_glass_nav_bar.dart';
import 'package:minvest_forex_app/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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

  void _rateApp() {
    final String url = Platform.isAndroid
        ? 'market://details?id=com.minvest.aisignals'
        : 'https://apps.apple.com/app/id6749299894?action=write-review';
    _launchURL(url);
  }

  void _showReferralCodeDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: const Color(0xFF161616),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.white10),
            ),
            title: Text(l10n.enterReferralCode, style: const TextStyle(color: Colors.white)),
            content: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: l10n.referralCode,
                hintStyle: const TextStyle(color: Colors.white38),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF276EFB))),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel, style: const TextStyle(color: Colors.white54)),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : () async {
                  final code = controller.text.trim();
                  if (code.isEmpty) return;

                  setState(() => isLoading = true);
                  try {
                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    final functions = FirebaseFunctions.instanceFor(region: 'asia-southeast1');
                    final callable = functions.httpsCallable('affiliateAttach');

                    await callable.call({
                      'uid': userProvider.uid,
                      'ref_code': code,
                      'ref_ts': DateTime.now().millisecondsSinceEpoch.toString(),
                    });
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.referralCodeApplied), backgroundColor: Colors.green),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      setState(() => isLoading = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.invalidReferralCode), backgroundColor: Colors.red),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF276EFB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(l10n.submit, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }
    );
  }

  void _shareApp() {
    const String message = 'Download Signal GPT - The Ultimate AI Engine for Forex Traders: https://minvest.vn/download';
    Share.share(message, subject: 'Signal GPT App');
  }

  void _handleLogout(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 342,
              height: 180, // Slightly taller to fit buttons
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.00, 0.78),
                  end: const Alignment(1.00, 0.20),
                  colors: [
                    Colors.white.withValues(alpha: 0.15),
                    Colors.white.withValues(alpha: 0.05),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Auto size height based on content
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 20),
                    child: Text(
                      l10n.confirmLogoutMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Be Vietnam Pro',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Back to Profile
                      context.read<AuthBloc>().add(SignOutRequested(
                        providersToReset: [
                          context.read<UserProvider>(),
                          context.read<NotificationProvider>(),
                        ],
                      ));
                    },
                    child: Container(
                      width: 122,
                      height: 44,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF0CA3ED), Color(0xFF276EFB)],
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.logout,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Be Vietnam Pro',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageSelection(BuildContext context) {
    final List<Map<String, String>> languages = [
      {'name': 'English', 'code': 'en', 'flag': 'assets/images/us_flag.png'},
      {'name': 'Vietnamese', 'code': 'vi', 'flag': 'assets/images/vn_flag.png'},
      {'name': 'Chinese', 'code': 'zh', 'flag': 'assets/images/cn_flag.png'},
      {'name': 'Japanese', 'code': 'ja', 'flag': 'assets/images/jp_flag.png'},
      {'name': 'Russian', 'code': 'ru', 'flag': 'assets/images/nga.png'},
      {'name': 'German', 'code': 'de', 'flag': 'assets/images/duc.png'},
      {'name': 'French', 'code': 'fr', 'flag': 'assets/images/fr_flag.png'},
      {'name': 'Korean', 'code': 'ko', 'flag': 'assets/images/kr_flag.png'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Consumer<LanguageProvider>(
          builder: (context, langProvider, child) {
            final currentLocale = langProvider.locale?.languageCode ?? 'en';
            final l10n = AppLocalizations.of(context)!;
            
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.04),
                    ],
                  ),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 1.5, color: Colors.white10),
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
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          l10n.selectLanguage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          itemCount: languages.length,
                          itemBuilder: (context, index) {
                            final lang = languages[index];
                            final isSelected = currentLocale == lang['code'];
                            final bool isTop = index == 0;
                            final bool isBottom = index == languages.length - 1;
                            
                            return GestureDetector(
                              onTap: () {
                                langProvider.setLocale(Locale(lang['code']!));
                                Navigator.pop(context);
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
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.asset(
                                        lang['flag']!,
                                        width: 32,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      lang['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Be Vietnam Pro',
                                      ),
                                    ),
                                    const Spacer(),
                                    if (isSelected)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF276EFB),
                                        size: 24,
                                      )
                                    else
                                      const Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.white10, // Very subtle unselected icon
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
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.setting,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // --- Subscriptions Section ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      l10n.subscriptions,
                      style: const TextStyle(color: Color(0xFF636363), fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    label: l10n.openTradingAccount,
                    icon: Icons.account_balance_wallet_outlined,
                    onTap: () => _launchURL('https://my.exmarkets.guide/accounts/sign-up/303589?utm_source=partners&ex_ol=1'),
                  ),

                  const SizedBox(height: 32),

                  // --- Support Us Section ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      l10n.supportUs,
                      style: const TextStyle(color: Color(0xFF636363), fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    label: l10n.rateApp,
                    icon: Icons.star_border,
                    onTap: _rateApp,
                  ),
                  _buildMenuButton(
                    label: l10n.shareApp,
                    icon: Icons.share_outlined,
                    onTap: _shareApp,
                  ),

                  const SizedBox(height: 32),

                  // --- Account Details Section ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      l10n.accountDetails,
                      style: const TextStyle(color: Color(0xFF636363), fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      if (userProvider.referredByAffiliateId == null) {
                        return _buildMenuButton(
                          label: l10n.enterReferralCode,
                          icon: Icons.card_giftcard_outlined,
                          onTap: () => _showReferralCodeDialog(context),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  _buildMenuButton(
                    label: l10n.changePassword,
                    icon: Icons.lock_outline,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                    },
                  ),
                  _buildMenuButton(
                    label: l10n.language,
                    icon: Icons.language,
                    onTap: () => _showLanguageSelection(context),
                  ),
                  _buildMenuButton(
                    label: l10n.logout,
                    icon: Icons.logout,
                    onTap: () => _handleLogout(context),
                  ),
                  _buildMenuButton(
                    label: l10n.notifications,
                    icon: Icons.notifications_none,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()),
                      );
                    },
                  ),
                  _buildMenuButton(
                    label: l10n.termsOfUse,
                    icon: Icons.description_outlined,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TermsOfUseScreen()),
                    ),
                  ),

                  const SizedBox(height: 40), // Compact space for Bottom Nav
                ],
              ),
            ),
          ),

          // Menu lơ lửng Liquid Glass
          Positioned(
            bottom: bottomPadding > 0 ? bottomPadding : 20,
            left: 0,
            right: 0,
            child: Center(
              child: LiquidGlassNavBar(
                selectedIndex: 3, // Settings belongs to Profile section (now index 3)
                onTap: (index) {
                  Navigator.pop(context); // Pop Settings
                  if (index != 3) {
                    mainScreenKey.currentState?.switchToTab(index);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.00, 1.00),
            end: const Alignment(1.00, 0.12),
            colors: [
              Colors.white.withValues(alpha: 0.10),
              Colors.white.withValues(alpha: 0.04),
            ],
          ),
          border: Border(
            bottom: BorderSide(
              width: 0.8,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
    );
  }
}
