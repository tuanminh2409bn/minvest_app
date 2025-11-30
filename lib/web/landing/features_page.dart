import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/theme/colors.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/landing/sections/features/win_more_section.dart';
import 'package:minvest_forex_app/web/landing/sections/features/smart_tools_section.dart';
import 'package:minvest_forex_app/web/landing/sections/features/your_on_demand_section.dart';
import 'package:minvest_forex_app/web/landing/sections/features/maximize_results_section.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 12),
                LandingNavBar(),
                SizedBox(height: 24),
                WinMoreSection(),
                SizedBox(height: 96),
                SmartToolsSection(),
                SizedBox(height: 96),
                YourOnDemandSection(),
                SizedBox(height: 96),
                MaximizeResultsSection(),
                SizedBox(height: 48),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
