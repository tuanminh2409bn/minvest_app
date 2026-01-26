import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'widgets/navbar.dart';
import 'sections/pricing_section.dart';
import 'sections/footer_section.dart';
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: const WebChatBubble(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
