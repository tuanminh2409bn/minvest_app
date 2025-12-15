import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/text_styles.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool stacked = constraints.maxWidth < 900;
      final double padH = stacked ? 16 : 32;

      Widget _bounded(Widget child, double maxWidth) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        );
      }

      final logoCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: Image.asset('assets/mockups/logo.png', height: 70),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppLocalizations.of(context)!.enterpriseCodeDetails,
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppLocalizations.of(context)!.addressDetails,
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
          ),
        ],
      );

      final pagesCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.pagesTitle, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          _navLink(context, AppLocalizations.of(context)!.feature, '/features'),
          _navLink(context, AppLocalizations.of(context)!.aiSignal, '/ai-signals'),
          _navLink(context, AppLocalizations.of(context)!.pricing, '/pricing'),
          _navLink(context, AppLocalizations.of(context)!.navNews, '/news'),
          _navLink(context, AppLocalizations.of(context)!.contactUs, '/contact-us'),
        ],
      );

      final legalCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.legalRegulatoryTitle, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          _textOnlyLink(context, AppLocalizations.of(context)!.termsOfRegistration),
          _textOnlyLink(context, AppLocalizations.of(context)!.operatingPrinciples),
          _textOnlyLink(context, AppLocalizations.of(context)!.termsConditions),
        ],
      );

      final contactCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.contactTitle, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.phone, color: Colors.white, size: 18),
              Text('+84 969 15 6969', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16)), // Number, not localized
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.email, color: Colors.white, size: 18),
              Text('email@gmail.com', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16)), // Email, not localized
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _SocialIcon(iconPath: 'assets/images/facebook_logo.png', url: 'https://www.facebook.com/minvest.vn'),
              _SocialIcon(iconPath: 'assets/images/tiktok_logo.png', url: 'https://www.tiktok.com/@minvest.minh'),
              _SocialIcon(iconPath: 'assets/images/youtube_logo.png', url: 'https://www.youtube.com/@minvestvn'),
              _SocialIcon(iconPath: 'assets/images/telegram_logo.png', url: 'https://t.me/minvest_free', size: 32),
              _SocialIcon(iconPath: 'assets/images/web_logo.png', url: 'https://minvest.vn/'),
            ],
          ),
        ],
      );

      final List<Widget> items = [
        _bounded(logoCol, 460),
        _bounded(pagesCol, 220),
        _bounded(legalCol, 220),
        _bounded(contactCol, 260),
      ];

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: padH, vertical: 48),
        child: stacked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items
                    .map(
                      (w) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: w,
                      ),
                    )
                    .toList(),
              )
            : Wrap(
                spacing: 32,
                runSpacing: 24,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: items,
              ),
      );
    });
  }

  Widget _navLink(BuildContext context, String text, String? route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: route != null
            ? () {
                Navigator.of(context).pushNamed(route);
              }
            : null,
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _textOnlyLink(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
      ),
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