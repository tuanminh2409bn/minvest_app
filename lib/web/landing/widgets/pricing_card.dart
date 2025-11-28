import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/gradients.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';

class PricingCard extends StatelessWidget {
  final String label;
  final String price;
  final String cycle;
  final List<String> features;
  const PricingCard({
    super.key,
    required this.label,
    required this.price,
    required this.cycle,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: AppGradients.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 12,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(cycle, style: AppTextStyles.caption.copyWith(color: Colors.white)),
                )
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: price, style: AppTextStyles.h3),
                  TextSpan(
                    text: ' / month',
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, size: 14, color: AppColors.accentBlue),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f, style: AppTextStyles.caption.copyWith(color: Colors.white))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppGradients.cta,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Get Signals Now', style: AppTextStyles.caption.copyWith(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Try demo', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
