import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/breakpoints.dart';
import 'widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/hero_subtitle_section.dart';
import 'sections/hero_signals_section.dart';
import 'sections/live_signals_section.dart';
import 'sections/order_engine_section.dart';
import 'sections/performance_section.dart';
import 'sections/core_value_section.dart';
import 'sections/pricing_section.dart';
import 'sections/faq_section.dart';
import 'sections/cta_section.dart';
import 'sections/footer_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth < Breakpoints.desktop && constraints.maxWidth >= Breakpoints.tablet;
          final isMobile = constraints.maxWidth < Breakpoints.tablet;
          final horizontalPadding = isMobile ? 16.0 : isTablet ? 24.0 : 32.0;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      SizedBox(height: 12),
                      LandingNavBar(),
                      HeroSection(),
                      HeroSubtitleSection(),
                      SizedBox(height: 96),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: HeroSignalsSection()),
                          SizedBox(width: 16),
                          Expanded(child: LiveSignalsSection()),
                        ],
                      ),
                      SizedBox(height: 96),
                      OrderEngineSection(),
                      SizedBox(height: 96),
                      PerformanceSection(),
                      SizedBox(height: 96),
                      CoreValueSection(),
                      SizedBox(height: 96),
                      PricingSection(),
                      FaqSection(),
                      CtaSection(),
                      FooterSection(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
