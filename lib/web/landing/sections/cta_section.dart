import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';
import '../widgets/gradient_button.dart';
import '../../theme/colors.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          children: [
            Text(
              'Maximize your results with Minvest AI advanced market analysis and precision-filtered signals',
              style: AppTextStyles.h3.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Elevate your trading with AI-enhanced strategies crafted for consistency and clarity.',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientButton(label: 'Get Signals Now', onPressed: () {}),
                const SizedBox(width: AppSpacing.md),
                TextButton(
                  onPressed: () {},
                  child: Text('Try demo', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
