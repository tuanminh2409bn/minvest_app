import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'widgets/navbar.dart';
import 'sections/pricing_section.dart';
import 'sections/footer_section.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8), // Giảm từ 16 xuống 8
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 12),
                  LandingNavBar(),
                  SizedBox(height: 32),
                  PricingSection(
                    heading: AppLocalizations.of(context)!.packageTitle,
                    subheading: AppLocalizations.of(context)!.choosePlanSubtitle,
                    headingFontSize: 36,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
