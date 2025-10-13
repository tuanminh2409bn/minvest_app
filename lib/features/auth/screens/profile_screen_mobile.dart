// lib/features/auth/screens/profile_screen_mobile.dart
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/features/admin/screens/admin_panel_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/verification/screens/upgrade_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Map<String, String> _getTierInfo(String tier, AppLocalizations l10n) {
    switch (tier.toLowerCase()) {
      case 'demo':
        return {
          l10n.signalTime: '8h-17h',
          l10n.lotPerWeek: '0.05',
          l10n.signalQty: '8 signals',
        };
      case 'vip':
        return {
          l10n.signalTime: '8h-17h',
          l10n.lotPerWeek: '0.3',
          l10n.signalQty: 'full',
        };
      case 'elite':
        return {
          l10n.signalTime: 'fulltime',
          l10n.lotPerWeek: '0.5',
          l10n.signalQty: 'full',
        };
      default: // Free tier
        return {
          l10n.signalTime: 'N/A',
          l10n.lotPerWeek: 'N/A',
          l10n.signalQty: 'N/A',
        };
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF161B22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(l10n.confirmLogout, style: const TextStyle(color: Colors.white)),
          content: Text(l10n.confirmLogoutMessage, style: const TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text(l10n.logout, style: const TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true && context.mounted) {
      final userProvider = context.read<UserProvider>();
      final notificationProvider = context.read<NotificationProvider>();
      context.read<AuthBloc>().add(
          SignOutRequested(providersToReset: [userProvider, notificationProvider])
      );
    }
  }
  Future<void> _handleDeleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF161B22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(l10n.deleteAccount, style: const TextStyle(color: Colors.redAccent)),
          content: Text(l10n.deleteAccountWarning, style: const TextStyle(color: Colors.white70)),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.cancel, style: const TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true && context.mounted) {
     context.read<AuthBloc>().add(DeleteAccountRequested());
      print('Delete account confirmed');
    }
  }
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;
    final userTier = userProvider.userTier ?? 'free';
    final userRole = userProvider.role ?? 'user';
    final l10n = AppLocalizations.of(context)!;
    final tierInfo = _getTierInfo(userTier, l10n);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color.fromARGB(255, 20, 29, 110)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: currentUser?.photoURL != null ? NetworkImage(currentUser!.photoURL!) : null,
                    child: currentUser?.photoURL == null ? const Icon(Icons.person, size: 40) : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          currentUser?.displayName ?? l10n.yourName,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          userTier.toUpperCase(),
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ...tierInfo.entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${entry.key}: ', style: const TextStyle(color: Colors.white, fontSize: 16)),
                        Flexible(child: Text(entry.value, style: const TextStyle(color: Colors.white, fontSize: 16))),
                      ],
                    ),
                  )),
                  const SizedBox(height: 30),
                  _UpgradeCard(),
                  const SizedBox(height: 20),
                  if (userRole == 'admin')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildActionButton(
                        text: l10n.adminPanel,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AdminPanelScreen()),
                          );
                        },
                      ),
                    ),
                  _buildActionButton(
                    text: l10n.contactUs247,
                    onPressed: () => _launchURL('https://zalo.me/0969156969'),
                  ),
                  const SizedBox(height: 16),

                  _buildActionButton(
                    text: l10n.deleteAccount,
                    onPressed: () => _handleDeleteAccount(context),
                    isDestructive: true,
                  ),
                  const SizedBox(height: 16),

                  _buildActionButton(
                    text: l10n.logout,
                    onPressed: () => _handleLogout(context),
                  ),
                  const SizedBox(height: 40),
                  Text(l10n.followMinvest, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialIcon(iconPath: 'assets/images/facebook_logo.png', url: 'https://www.facebook.com/minvest.vn'),
                      const SizedBox(width: 20),
                      _SocialIcon(iconPath: 'assets/images/tiktok_logo.png', url: 'https://www.tiktok.com/@minvest.minh'),
                      const SizedBox(width: 20),
                      _SocialIcon(iconPath: 'assets/images/youtube_logo.png', url: 'https://www.youtube.com/@minvestvn'),
                      const SizedBox(width: 20),
                      _SocialIcon(iconPath: 'assets/images/telegram_logo.png', url: 'https://t.me/minvest_free', size: 32),
                      const SizedBox(width: 20),
                      _SocialIcon(iconPath: 'assets/images/web_logo.png', url: 'https://minvest.vn/'),
                    ],
                  ),

                  const SizedBox(height: 30),
                  _buildInfoLinks(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoLinks(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => _launchURL('https://tuanminh2409bn.github.io/minvest-privacy/'),
          child: Text(
            l10n.privacyPolicy,
            style: const TextStyle(color: Colors.white70, decoration: TextDecoration.underline, decorationColor: Colors.white70),
          ),
        ),
        const Text("•", style: TextStyle(color: Colors.white70)),
        TextButton(
          onPressed: () => _launchURL('https://tuanminh2409bn.github.io/minvest-terms/'),
          child: Text(
            l10n.termsOfService,
            style: const TextStyle(color: Colors.white70, decoration: TextDecoration.underline, decorationColor: Colors.white70),
          ),
        ),
      ],
    );
  }
// MỚI KẾT THÚC
}

// ... các Widget còn lại giữ nguyên ...
class _UpgradeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF157CC9),
            Color(0xFF2A43B9),
            Color(0xFFC611CE),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.workspace_premium, color: Colors.amber, size: 32),
          const SizedBox(height: 8),
          Text(
            l10n.upgradeCardTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.upgradeCardSubtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpgradeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue.shade800,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text(l10n.upgradeNow, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// MỚI: Cập nhật hàm buildActionButton để có thể tùy chỉnh style
Widget _buildActionButton({required String text, required VoidCallback onPressed, bool isDestructive = false}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDestructive
                ? [const Color(0xFF8B0000), const Color(0xFFB22222)] // Màu đỏ cho hành động xóa
                : [const Color(0xFF0C0938), const Color(0xFF141A4C), const Color(0xFF1D2B62)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ),
  );
}


class _SocialIcon extends StatelessWidget {
  final String iconPath;
  final String url;
  final double size;

  const _SocialIcon({
    required this.iconPath,
    required this.url,
    this.size = 32.0,
  });

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}