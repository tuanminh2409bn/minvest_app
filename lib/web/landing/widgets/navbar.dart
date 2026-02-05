import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/core/providers/language_provider.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
import '../../theme/text_styles.dart';
import '../../theme/gradients.dart';
import '../../theme/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/screens/welcome/welcome_screen.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/core/providers/user_provider.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';
import 'package:minvest_forex_app/features/notifications/screens/notification_screen_web.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';

class _ProfilePopup extends StatelessWidget {
  final User user;
  final Offset buttonPosition;
  final Size buttonSize;

  const _ProfilePopup({
    required this.user,
    required this.buttonPosition,
    required this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String name = (userProvider.displayName ?? user.displayName ?? user.email ?? 'User').trim();

    // Popup dimensions from Figma logic
    final double popupWidth = 250;
    
    // Position the popup so it's aligned with the button
    double right = size.width - (buttonPosition.dx + buttonSize.width);
    double top = buttonPosition.dy - 10; // Align top or slightly offset

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: top,
          right: right,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: popupWidth,
              height: 226,
              child: Stack(
                children: [
                  // User Info Header (Top part)
                  Positioned(
                    left: 40,
                    top: 0,
                    child: Container(
                      width: 210,
                      height: 59,
                      padding: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            name,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.9,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _AvatarCircle(user: user),
                        ],
                      ),
                    ),
                  ),
                  
                  // Menu Items
                  _buildMenuItem(context, 
                    top: 70, 
                    title: 'Profile', 
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/profile', arguments: 0);
                    }
                  ),
                  _buildMenuItem(context, 
                    top: 107, 
                    title: 'Email preferences', 
                    borderRadius: BorderRadius.zero, // Middle item
                    hasBottomBorder: true,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed('/profile', arguments: 1);
                    }
                  ),
                  _buildMenuItem(context, 
                    top: 144, 
                    title: 'Log out', 
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => const _LogoutDialog(),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required double top, 
    required String title, 
    required BorderRadius borderRadius,
    required VoidCallback onTap,
    bool hasBottomBorder = false,
  }) {
    return Positioned(
      left: 58,
      top: top,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 192,
          height: 37,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: borderRadius,
            border: Border.all(color: const Color(0xFF3D3D3D), width: 1),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 22),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.9,
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 384,
        height: 227,
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          shadows: const [
            BoxShadow(
              color: Color(0x66B49CFF),
              blurRadius: 8,
              offset: Offset(0, 0),
              spreadRadius: 2,
            )
          ],
        ),
        child: Stack(
          children: [
            // Header bar with separator
            Positioned(
              left: 0,
              top: 0,
              child: Opacity(
                opacity: 0.30,
                child: Container(
                  width: 384,
                  height: 51.72,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
                  ),
                ),
              ),
            ),
            // Title
            const Positioned(
              left: 0,
              right: 0,
              top: 17,
              child: Text(
                'Confirm Logout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.90,
                ),
              ),
            ),
            // Content text
            const Positioned(
              left: 33,
              right: 33,
              top: 85,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Are you sure you want to log out?\n',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.90,
                      ),
                    ),
                    TextSpan(
                      text: 'You will be redirected to the login page.',
                      style: TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.90,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Cancel Button
            Positioned(
              left: 147,
              bottom: 15,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 78,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF424242), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.90,
                    ),
                  ),
                ),
              ),
            ),
            // Logout Button
            Positioned(
              right: 33,
              bottom: 15,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  context.read<AuthBloc>().add(SignOutRequested(providersToReset: [
                    context.read<UserProvider>(),
                    context.read<NotificationProvider>(),
                  ]));
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                child: Container(
                  width: 114,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.90,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final User user;
  const _AvatarCircle({required this.user});

  @override
  Widget build(BuildContext context) {
    final photoUrl = user.photoURL;
    return Container(
      width: 37,
      height: 37,
      decoration: const BoxDecoration(
        color: Color(0xFFD9D9D9),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: photoUrl != null
                ? DecorationImage(image: NetworkImage(photoUrl), fit: BoxFit.cover)
                : null,
            color: photoUrl == null ? Colors.white24 : null,
          ),
          child: photoUrl == null
              ? const Icon(Icons.person, color: Colors.white, size: 18)
              : null,
        ),
      ),
    );
  }
}

class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> navItems = [
      {'title': l10n.navFeatures, 'route': '/features'},
      {'title': l10n.aiSignal, 'route': '/ai-signals'},
      {'title': l10n.pricing, 'route': '/pricing'},
      {'title': l10n.navNews, 'route': '/news'},
      {'title': l10n.contactUs, 'route': '/contact-us'},
    ];

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: isMobile ? const TextScaler.linear(0.9) : const TextScaler.linear(1.0),
        ),
        child: RepaintBoundary(
          child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return LayoutBuilder(builder: (context, constraints) {
            final bool stacked = constraints.maxWidth < 720;
            final bool isCompact = constraints.maxWidth < 1250;
            final double padH = 0;
            final double padV = stacked ? 12 : 6;
            
            final currentLang = Localizations.localeOf(context).languageCode;
            final isFrench = currentLang == 'fr';

            // Only reduce spacing for French
            final navSpacing = isFrench ? 20.0 : 32.0;
            
            final fontSize = stacked
                ? 16.0 // Slightly larger for mobile
                : 18.0; // Consistent 18.0 for desktop as per Figma
            
            // Only reduce logo gap for French
            final double logoGap = isFrench 
                ? (isCompact ? 32.0 : 64.0) 
                : (isCompact ? 64.0 : 110.0);

            final navLinks = Row(
              mainAxisSize: MainAxisSize.min,
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
            );

            final verticalNavLinks = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...navItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _NavBarItem(
                      title: item['title']!,
                      route: item['route']!,
                      fontSize: 20, // Reduced for mobile
                    ),
                  ),
                ),
              ],
            );

            final actions = Row(
              children: [
                if (user == null) ...[
                  Expanded(
                    flex: 3,
                    child: _ctaButton(context, l10n.getSignalsNow, isMobile: isMobile),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    flex: 2,
                    child: _outlineButton(
                      context,
                      l10n.signIn,
                      isMobile: isMobile,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      ),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: _userNameChip(
                      context,
                      user,
                      onTap: () => Navigator.of(context).pushNamed('/profile'),
                    ),
                  ),
                ],
              ],
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
              child: stacked
                  ? _MobileNavBar(navLinks: verticalNavLinks, actions: actions)
                  : Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pushNamed('/'),
                          child: Image.asset('assets/mockups/logo.png', height: 50, fit: BoxFit.contain),
                        ),
                        SizedBox(width: logoGap),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center, // Căn giữa rõ ràng hơn
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: navLinks,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16), // Khoảng cách an toàn trước khi đến cụm nút
                        // Actions on desktop
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (user == null) ...[
                              _ctaButton(context, l10n.getSignalsNow, isMobile: false),
                              const SizedBox(width: AppSpacing.sm),
                              _outlineButton(
                                context,
                                l10n.signIn,
                                isMobile: false,
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
                          ],
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        const _LanguageSelector(),
                        const SizedBox(width: AppSpacing.sm),
                        const _NotificationBell(),
                      ],
                    ),
            );
          });
        },
      ),
    ));
  }

  Widget _ctaButton(BuildContext context, String text, {required bool isMobile}) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('/signup'),
        child: Container(
          // Kích thước cố định theo Figma: 188x38 cho EN, co giãn cho ngôn ngữ khác
          width: (isEnglish && !isMobile) ? 188 : null,
          constraints: (isEnglish && !isMobile) ? null : const BoxConstraints(minWidth: 188),
          height: isMobile ? 48 : 38,
          padding: const EdgeInsets.all(1), // Luôn giữ viền 1px
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isMobile ? 1 : 6),
            gradient: const LinearGradient(
              colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 6)),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 1 : 5),
              color: Colors.transparent,
            ),
            padding: (isEnglish && !isMobile) ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Giúp nút không bị giãn hết cỡ
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: isMobile ? 20 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(BuildContext context, String text, {required bool isMobile, VoidCallback? onTap}) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Builder(
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Container(
          // Kích thước cố định theo Figma: 100x38 cho EN
          width: (isEnglish && !isMobile) ? 100 : null,
          constraints: (isEnglish && !isMobile) ? null : const BoxConstraints(minWidth: 100),
          height: isMobile ? 48 : 38,
          padding: const EdgeInsets.all(1), // Luôn giữ viền 1px
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isMobile ? 1 : 6),
            gradient: AppGradients.cta, // Viền gradient
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 1 : 5),
              color: Colors.black, // Nền đen
            ),
            padding: (isEnglish && !isMobile) ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: isMobile ? 20 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userNameChip(BuildContext context, User user, {VoidCallback? onTap}) {
    final userProvider = Provider.of<UserProvider>(context);
    final String name = (userProvider.displayName ?? user.displayName ?? user.email ?? 'User').trim();
    
    // Check for premium status
    final tier = userProvider.userTier?.toLowerCase() ?? 'free';
    final activeSubs = userProvider.activeSubscriptions;
    final isPremium = tier == 'elite' || (activeSubs != null && activeSubs.isNotEmpty);

    final GlobalKey buttonKey = GlobalKey();

    return GestureDetector(
      key: buttonKey,
      onTap: () {
        final RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;

        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (context) => _ProfilePopup(
            user: user,
            buttonPosition: offset,
            buttonSize: size,
          ),
        );
      },
      child: Container(
        height: 59, // Figma height
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.transparent, // Figma has alpha: 0
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              textAlign: TextAlign.right, // Figma spec
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Be Vietnam Pro',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.9,
              ),
            ),
            const SizedBox(width: 12),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _AvatarCircle(user: user),
                if (isPremium)
                  Positioned(
                    top: -16,
                    right: -10,
                    child: Transform.rotate(
                      angle: 40 * math.pi / 180,
                      child: Image.asset(
                        'assets/images/crown_icon.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
              ],
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
      case 'hi': return 'assets/images/ando.png';
      case 'ar': return 'assets/images/arapxeut.png';
      case 'pt': return 'assets/images/bodaonha.png';
      case 'km': return 'assets/images/campuchia.png';
      case 'cs': return 'assets/images/conghoasec.png';
      case 'da': return 'assets/images/danmach.png';
      case 'de': return 'assets/images/duc.png';
      case 'hu': return 'assets/images/hungary.png';
      case 'id': return 'assets/images/indonesia.png';
      case 'it': return 'assets/images/italy.png';
      case 'ms': return 'assets/images/malaysia.png';
      case 'mn': return 'assets/images/mongco.png';
      case 'ru': return 'assets/images/nga.png';
      case 'fi': return 'assets/images/phanlan.png';
      case 'ro': return 'assets/images/romania.png';
      case 'es': return 'assets/images/taybannha.png';
      case 'th': return 'assets/images/thailan.png';
      default: return '';
    }
  }

  Widget _buildFlag(String code, {double width = 24, double height = 16}) {
    final asset = _getFlagAsset(code);
    if (asset.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.asset(asset, width: width, height: height, fit: BoxFit.cover),
      );
    }
    return Text(
      code.toUpperCase(),
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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
      case 'hi': return 'हिन्दी';
      case 'ar': return 'العربية';
      case 'pt': return 'Português';
      case 'km': return 'ភាសាខ្មែរ';
      case 'cs': return 'Čeština';
      case 'da': return 'Dansk';
      case 'de': return 'Deutsch';
      case 'hu': return 'Magyar';
      case 'id': return 'Bahasa';
      case 'it': return 'Italiano';
      case 'ms': return 'Bahasa Melayu';
      case 'mn': return 'Монгол';
      case 'ru': return 'Русский';
      case 'fi': return 'Suomi';
      case 'ro': return 'Română';
      case 'es': return 'Español';
      case 'th': return 'ไทย';
      default: return code.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey buttonKey = GlobalKey();

    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          key: buttonKey,
          onTap: () {
            final RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero);
            final size = renderBox.size;

            showDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) => _LanguagePopup(
                provider: provider,
                getFlagAsset: _getFlagAsset,
                getLanguageName: _getLanguageName,
                buttonPosition: offset,
                buttonSize: size,
              ),
            );
          },
          child: Container(
            height: 31,
            width: 50.38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: const Color(0xFF3F3F3F), width: 1),
              color: Colors.black,
            ),
            child: Center(
              child: _buildFlag(provider.locale?.languageCode ?? 'en', width: 43.39, height: 22.85),
            ),
          ),
        );
      },
    );
  }
}

class _LanguagePopup extends StatelessWidget {
  final LanguageProvider provider;
  final String Function(String) getFlagAsset;
  final String Function(String) getLanguageName;
  final Offset buttonPosition;
  final Size buttonSize;

  const _LanguagePopup({
    required this.provider,
    required this.getFlagAsset,
    required this.getLanguageName,
    required this.buttonPosition,
    required this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    
    // Popup dimensions
    final double popupWidth = isMobile ? size.width * 0.9 : 450;
    final double popupMaxHeight = 400;

    // Calculate Position
    double? left;
    double? right;

    if (isMobile) {
      // Center on mobile
      left = (size.width - popupWidth) / 2;
    } else {
      // Right aligned with button on desktop
      right = size.width - (buttonPosition.dx + buttonSize.width);
      if (right < 16) right = 16; // Margin from screen edge
    }

    double top = buttonPosition.dy + buttonSize.height + 8;

    return Stack(
      children: [
        // Barrier to close on tap outside
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: top,
          right: right,
          left: left,
          child: Material(
            color: Colors.transparent,
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: popupWidth,
              constraints: BoxConstraints(maxHeight: popupMaxHeight),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 3,
                  childAspectRatio: 3.2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: LanguageProvider.supportedLocales.length,
                itemBuilder: (context, index) {
                  final locale = LanguageProvider.supportedLocales[index];
                  final isSelected = provider.locale?.languageCode == locale.languageCode;
                  
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        provider.setLocale(locale);
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? const Color(0xFF04B3E9) : Colors.white.withOpacity(0.1),
                            width: isSelected ? 1.5 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected ? const Color(0xFF04B3E9).withOpacity(0.15) : Colors.white.withOpacity(0.05),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white24, width: 0.5),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.asset(
                                  getFlagAsset(locale.languageCode),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                getLanguageName(locale.languageCode),
                                style: TextStyle(
                                  color: isSelected ? const Color(0xFF04B3E9) : Colors.white,
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed('/'),
              child: Image.asset('assets/mockups/logo.png', height: 40, fit: BoxFit.contain),
            ),
            const Spacer(),
            const _LanguageSelector(),
            const SizedBox(width: 8),
            const _NotificationBell(),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(_menuOpen ? Icons.close : Icons.menu, color: Colors.white),
              onPressed: () => setState(() => _menuOpen = !_menuOpen),
            ),
          ],
        ),
        if (_menuOpen) ...[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: widget.navLinks,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: widget.actions,
          ),
          const SizedBox(height: 24),
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

    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return RepaintBoundary(
      child: MouseRegion(
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = false);
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(widget.route);
        },
        child: Container(
          // Giới hạn chiều rộng để ép xuống dòng nếu chữ quá dài, tránh đè lên nút
          constraints: const BoxConstraints(maxWidth: 120),
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.visible,
            style: const TextStyle(
              fontSize: 18, // Base size, can be overridden by widget.fontSize if passed correctly
              fontWeight: FontWeight.w600, // Figma: w600
              color: Colors.white, // Will be overridden by color variable
              fontFamily: 'Be Vietnam Pro',
              letterSpacing: -0.90, // Figma: -0.90
              height: 1.2,
            ).copyWith(color: color, fontSize: widget.fontSize),
          ),
        ),
      ),
    ));
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, _) {
        final count = provider.unreadCount;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.bell, color: Colors.white, size: 24),
              tooltip: 'Notifications',
            ),
            if (count > 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
