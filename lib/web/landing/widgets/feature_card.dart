import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  const FeatureCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(description, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
