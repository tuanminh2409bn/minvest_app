import 'package:flutter/material.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import '../../theme/text_styles.dart';

class OperatingPrinciplesPage extends StatelessWidget {
  const OperatingPrinciplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Go Back Button
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/'),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: Text(
                    AppLocalizations.of(context)!.goBack,
                    style: AppTextStyles.body.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  AppLocalizations.of(context)!.operatingPrinciples,
                  style: AppTextStyles.h1.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
                // Content Placeholder
                Text(
                  AppLocalizations.of(context)!.operatingPrinciplesContent,
                  style: AppTextStyles.body.copyWith(color: Colors.white70, height: 1.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
