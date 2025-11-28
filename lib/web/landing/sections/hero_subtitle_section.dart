import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';

class HeroSubtitleSection extends StatelessWidget {
  const HeroSubtitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
      child: Column(
        children: [
          Text(
            'Global AI Innovation for the Next Generation of Trading Intelligence',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Transforming traditional trading with cloud-powered AI signals — adaptive to real-time market news and trends for faster, more precise, and emotion-free performance.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
