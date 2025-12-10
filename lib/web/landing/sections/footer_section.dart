import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/text_styles.dart';

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
            'Enterprise code: 0107136243 is issued by the Hanoi Department of Finance on 24/11/2015; 6th amendment registered by the Hanoi Department of Finance on 05/08/2025.',
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Address: C2810, 18th Floor, C2 Building, HH Lot, Dong Nam Urban Area, Tran Duy Hung St., Yen Hoa Ward, Hanoi, Vietnam.)',
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
          ),
        ],
      );

      final pagesCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pages', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          _navLink(context, 'Features', '/features'),
          _navLink(context, 'AI Signals', '/ai-signals'),
          _navLink(context, 'Pricing', '/pricing'),
          _navLink(context, 'News', '/news'),
          _navLink(context, 'Contact Us', '/contact-us'),
        ],
      );

      final legalCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Legal & Regulatory', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          _textOnlyLink('Terms Of Registration'),
          _textOnlyLink('Operating Principles'),
          _textOnlyLink('Terms & Conditions'),
        ],
      );

      final contactCol = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.phone, color: Colors.white, size: 18),
              Text('+84 969 15 6969', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.email, color: Colors.white, size: 18),
              Text('email@gmail.com', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              6,
              (_) => Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  shape: BoxShape.circle,
                ),
              ),
            ),
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

  Widget _textOnlyLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
