import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/content.dart';
import '../../theme/text_styles.dart';
import '../../theme/gradients.dart';
import '../../theme/spacing.dart';

class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          Image.asset('assets/mockups/logo.png', height: 46, fit: BoxFit.contain),
          const Spacer(),
          ...LandingContent.navItems.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                item,
                style: AppTextStyles.h3.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          _ctaButton('Get Signals now'),
          const SizedBox(width: AppSpacing.sm),
          _outlineButton('Sign in'),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 40,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset('assets/images/us_flag.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ctaButton(String text) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFFD500F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 6)),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Text(
          text,
          style: AppTextStyles.h3.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String text) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppGradients.cta,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Text(
          text,
          style: AppTextStyles.h3.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
