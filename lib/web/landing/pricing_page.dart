import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'widgets/navbar.dart';
import 'sections/pricing_section.dart';
import 'sections/footer_section.dart';

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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 12),
                  LandingNavBar(),
                  SizedBox(height: 32),
                  PricingSection(
                    heading: 'Pricing Plans',
                    subheading: 'Choose a plan that works for you',
                    headingFontSize: 36,
                  ),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
