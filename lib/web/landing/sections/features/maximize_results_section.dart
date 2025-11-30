import 'package:flutter/material.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';

class MaximizeResultsSection extends StatelessWidget {
  const MaximizeResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            'Maximize your results with Minvest AI\nadvanced market analysis and precision-filtered signals',
            style: AppTextStyles.h1.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Minvest AI registration is now open — spots may close soon as we review and approve new members.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          _ctaButton(),
        ],
      ),
    );
  }

  Widget _ctaButton() {
    return Container(
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFF2E60FF), Color(0xFFD500F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text(
          'Get Signals now',
          style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
