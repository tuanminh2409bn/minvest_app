import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/gradients.dart';
import '../../theme/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/welcome_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';

class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> navItems = [
      {'title': l10n.navFeatures, 'route': '/features'},
      {'title': l10n.aiSignal, 'route': '/ai-signals'},
      {'title': l10n.pricing, 'route': '/pricing'},
      {'title': l10n.navNews, 'route': '/news'},
      {'title': l10n.contactUs, 'route': '/contact-us'},
    ];

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return LayoutBuilder(builder: (context, constraints) {
          final bool stacked = constraints.maxWidth < 720;
          // Tăng ngưỡng breakpoint lên 1250 để xử lý sớm các ngôn ngữ dài như tiếng Pháp
          final bool isCompact = constraints.maxWidth < 1250; 
          
          final double padH = stacked ? 12 : 24;
          final double padV = stacked ? 12 : 6;
          
          // Tinh chỉnh khoảng cách giữa các item: Nhỏ hơn khi ở chế độ Compact
          final navSpacing = stacked
              ? 10.0
              : isCompact
                  ? 14.0 
                  : 24.0;
                  
          // Giảm nhẹ font size khi không gian hẹp
          final fontSize = stacked
              ? 14.0
              : isCompact
                  ? 14.5
                  : 16.0;

          // Khoảng cách giữa Logo và Menu: Giảm đáng kể khi ở chế độ Compact (từ 82 -> 32)
          final double logoGap = isCompact ? 32.0 : 64.0;

          final navLinks = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...navItems.map(
                  (item) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: navSpacing / 2),
                    child: _NavBarItem(
                      title: item['title']!,
                      route: item['route']!,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ],
            ),
          );

          final actions = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user == null) ...[
                _ctaButton(context, l10n.getSignalsNow),
                const SizedBox(width: AppSpacing.sm),
                _outlineButton(
                  context,
                  l10n.signIn,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  ),
                ),
              ] else ...[
                _userNameChip(
                  context,
                  user,
                  onTap: () => Navigator.of(context).pushNamed('/profile'),
                ),
              ],
              const SizedBox(width: AppSpacing.sm),
              const _LanguageSelector(),
            ],
          );

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
            child: stacked
                ? _MobileNavBar(navLinks: navLinks, actions: actions)
                : Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed('/'),
                        child: Image.asset('assets/mockups/logo.png', height: 42, fit: BoxFit.contain),
                      ),
                      SizedBox(width: logoGap), // Sử dụng khoảng cách linh hoạt
                      Expanded(child: navLinks),
                      actions,
                    ],
                  ),
          );
        });
      },
    );
  }

  Widget _ctaButton(BuildContext context, String text) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('/signup'),
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xFF00BFFF), Color(0xFFD500F9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 6)),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.transparent,
            ),
            child: Text(
              text,
              style: AppTextStyles.h3.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(BuildContext context, String text, {VoidCallback? onTap}) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: AppGradients.cta,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            child: Text(
              text,
              style: AppTextStyles.h3.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userAvatar(User user, {VoidCallback? onTap}) {
    final photoUrl = user.photoURL;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
          image: photoUrl != null
              ? DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.cover)
              : null,
          color: photoUrl == null ? Colors.white24 : null,
        ),
        child: photoUrl == null
            ? const Icon(Icons.person, color: Colors.white, size: 18)
            : null,
      ),
    );
  }

  Widget _userNameChip(BuildContext context, User user, {VoidCallback? onTap}) {
    final userProvider = Provider.of<UserProvider>(context);
    final String name = (userProvider.displayName ?? user.displayName ?? user.email ?? 'User').trim();
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
          color: Colors.white.withOpacity(0.06),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _userAvatar(user, onTap: onTap),
            const SizedBox(width: 8),
            Text(
              name,
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  String _getFlagAsset(String code) {
    switch (code) {
      case 'en': return 'assets/images/us_flag.png';
      case 'vi': return 'assets/images/vn_flag.png';
      case 'ja': return 'assets/images/jp_flag.png';
      case 'fr': return 'assets/images/fr_flag.png';
      case 'zh': return 'assets/images/cn_flag.png';
      case 'ko': return 'assets/images/kr_flag.png';
      default: return '';
    }
  }

  Widget _buildFlag(String code) {
    final asset = _getFlagAsset(code);
    if (asset.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(asset, width: 24, height: 16, fit: BoxFit.cover),
      );
    }
    return Text(
      code.toUpperCase(),
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return PopupMenuButton<Locale>(
          onSelected: (Locale newLocale) {
            provider.setLocale(newLocale);
          },
          offset: const Offset(0, 40),
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          itemBuilder: (BuildContext context) {
            return LanguageProvider.supportedLocales.map((Locale locale) {
              return PopupMenuItem<Locale>(
                value: locale,
                child: Row(
                  children: [
                    Container(
                      width: 32, 
                      height: 20, 
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: _buildFlag(locale.languageCode),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _getLanguageName(locale.languageCode),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList();
          },
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white24),
              color: Colors.white.withOpacity(0.05),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32, 
                  height: 20, 
                  alignment: Alignment.center,
                  child: _buildFlag(provider.locale?.languageCode ?? 'en'),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en': return 'English';
      case 'vi': return 'Tiếng Việt';
      case 'zh': return '中文';
      case 'fr': return 'Français';
      case 'ja': return '日本語';
      case 'ko': return '한국어';
      default: return code.toUpperCase();
    }
  }
}

class _MobileNavBar extends StatefulWidget {
  final Widget navLinks;
  final Widget actions;
  const _MobileNavBar({required this.navLinks, required this.actions});

  @override
  State<_MobileNavBar> createState() => _MobileNavBarState();
}

class _MobileNavBarState extends State<_MobileNavBar> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed('/'),
              child: Image.asset('assets/mockups/logo.png', height: 38, fit: BoxFit.contain),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(_menuOpen ? Icons.close : Icons.menu, color: Colors.white),
              onPressed: () => setState(() => _menuOpen = !_menuOpen),
            ),
          ],
        ),
        if (_menuOpen) ...[
          const SizedBox(height: 12),
          Align(alignment: Alignment.centerLeft, child: widget.navLinks),
          const SizedBox(height: 12),
          Align(alignment: Alignment.center, child: widget.actions),
        ],
      ],
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String title;
  final String route;
  final double fontSize;

  const _NavBarItem({
    required this.title,
    required this.route,
    required this.fontSize,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == widget.route;
    
    // Yêu cầu: Active color = Hover color = 0xFF04B3E9
    final color = (isActive || _isHovered) 
        ? const Color(0xFF04B3E9) 
        : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(widget.route);
        },
        child: Text(
          widget.title,
          style: AppTextStyles.h3.copyWith(
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}
