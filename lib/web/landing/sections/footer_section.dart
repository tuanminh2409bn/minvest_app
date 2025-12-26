import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
import '../../theme/spacing.dart';
import '../../theme/text_styles.dart';

import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        // Breakpoint cho mobile/tablet tăng lên 1100 để đảm bảo không gian cho các cột
        final bool isMobileLayout = constraints.maxWidth < 1100;
        final double padH = 0; // Đã loại bỏ padding ngang nội bộ để thẳng hàng với body

        final logoCol = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pushNamed('/'),
              child: Image.asset('assets/mockups/logo.png', height: 60, fit: BoxFit.contain),
            ),
            const SizedBox(height: AppSpacing.md),
            // Explicitly align this column to the left
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.companyName,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white, 
                      fontSize: isMobileLayout ? 18 : 15, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    AppLocalizations.of(context)!.addressDetails,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70, 
                      fontSize: isMobileLayout ? 16 : 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.enterpriseCodeDetails,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white70, 
                      fontSize: isMobileLayout ? 16 : 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        final pagesCol = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.pagesTitle, 
                style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: isMobileLayout ? 16 : 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.md),
            _FooterLink(text: AppLocalizations.of(context)!.feature, route: '/features', isMobile: isMobileLayout),
            _FooterLink(text: AppLocalizations.of(context)!.aiSignal, route: '/ai-signals', isMobile: isMobileLayout),
            _FooterLink(text: AppLocalizations.of(context)!.pricing, route: '/pricing', isMobile: isMobileLayout),
            _FooterLink(text: AppLocalizations.of(context)!.navNews, route: '/news', isMobile: isMobileLayout),
            _FooterLink(text: AppLocalizations.of(context)!.contactUs, route: '/contact-us', isMobile: isMobileLayout),
          ],
        );

        final legalCol = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.legalRegulatoryTitle, 
                style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: isMobileLayout ? 16 : 18, fontWeight: FontWeight.w700, overflow: TextOverflow.visible), softWrap: false),
            const SizedBox(height: AppSpacing.md),
            _FooterLink(text: AppLocalizations.of(context)!.termsOfRegistration, route: '/terms-of-registration', isMobile: isMobileLayout),
            _FooterLink(text: AppLocalizations.of(context)!.operatingPrinciples, route: '/operating-principles', isMobile: isMobileLayout),
            _FooterLink(text: AppLocalizations.of(context)!.termsConditions, route: '/terms-conditions', isMobile: isMobileLayout),
          ],
        );

        final contactCol = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.contactTitle, 
                style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: isMobileLayout ? 16 : 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: AppSpacing.md),
            _ContactItem(icon: Icons.phone, text: '+84 969.15.6969', isMobile: isMobileLayout),
            const SizedBox(height: 8),
            _ContactItem(icon: Icons.email, text: 'contact@minvest.vn', isMobile: isMobileLayout),
          ],
        );

        final socialIcons = Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: const [
            _SocialIcon(iconPath: 'assets/images/facebook_logo.png', url: 'https://www.facebook.com/minvest.vn'),
            _SocialIcon(iconPath: 'assets/images/tiktok_logo.png', url: 'https://www.tiktok.com/@minvest.minh'),
            _SocialIcon(iconPath: 'assets/images/youtube_logo.png', url: 'https://www.youtube.com/@minvestvn'),
            _SocialIcon(iconPath: 'assets/images/telegram_logo.png', url: 'https://t.me/minvest_free', size: 32),
            _SocialIcon(iconPath: 'assets/images/web_logo.png', url: 'https://minvest.vn/'),
          ],
        );

        return Container(
          padding: EdgeInsets.symmetric(horizontal: padH, vertical: 64),
          color: Colors.black, // Đảm bảo nền đen nếu cần
          child: isMobileLayout
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    logoCol,
                    const SizedBox(height: 40),
                    // Row for 3 columns on mobile
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 4, child: pagesCol),
                        const SizedBox(width: 4),
                        Expanded(flex: 5, child: legalCol),
                        const SizedBox(width: 4),
                        Expanded(flex: 4, child: contactCol),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Center(child: socialIcons),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cột 1: Logo & Info (Giảm flex xuống 3)
                    Expanded(
                      flex: 5,
                      child: logoCol,
                    ),
                    const SizedBox(width: 40),
                    // Cột 2: Pages (Giữ nguyên flex 2)
                    Expanded(
                      flex: 2,
                      child: pagesCol,
                    ),
                    // Cột 3: Legal (Tăng flex lên 4 để chứa chữ dài)
                    Expanded(
                      flex: 3,
                      child: legalCol,
                    ),
                    // Cột 4: Contact (Flex 3)
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          contactCol,
                          const SizedBox(height: AppSpacing.lg),
                          socialIcons,
                        ],
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isMobile;

  const _ContactItem({required this.icon, required this.text, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: isMobile ? 16 : 18),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text, 
            style: AppTextStyles.body.copyWith(
              color: Colors.white, 
              fontSize: isMobile ? 13 : 16,
            ),
          ),
        ),
      ],
    );
  }
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
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
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final String? route;
  final bool isMobile;

  const _FooterLink({required this.text, this.route, this.isMobile = false});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), 
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.route != null
              ? () {
                  Navigator.of(context).pushNamed(widget.route!);
                }
              : null,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4), 
                child: Text(
                  widget.text,
                  softWrap: true, // Allow wrapping if needed
                  overflow: TextOverflow.visible,
                  style: AppTextStyles.body.copyWith(
                    color: _isHovered ? Colors.white : Colors.white70,
                    fontSize: widget.isMobile ? 13 : 15, // Reduce size on mobile
                    height: 1.2,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          height: 1.5,
                          width: _isHovered ? constraints.maxWidth : 0,
                          color: Colors.white,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}