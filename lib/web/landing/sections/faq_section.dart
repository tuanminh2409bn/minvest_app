import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';
import '../../theme/content.dart';
import '../widgets/faq_tile.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Frequently Asked Questions (FAQ)', style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Simplifying your journey. Quick answers to common questions about how Minvest works.',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Column(
            children: LandingContent.faqItems
                .map((f) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: FaqTile(question: f['question']!),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
