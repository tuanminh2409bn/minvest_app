import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';

class LiveSignalsSection extends StatelessWidget {
  const LiveSignalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: Container(
        constraints: const BoxConstraints(minHeight: 480),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _chip('AI Signals'),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'LIVE – 24/7 AI Trading Signals',
              style: AppTextStyles.h1.copyWith(fontSize: 42, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Real-time cloud analytics delivering high-probability, trend-following strategies with adaptive precision and emotion-free execution.',
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                _outlinedChip('AI Signals'),
                _outlinedChip('Trend-Following'),
                _outlinedChip('Real-time'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.black,
        ),
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _outlinedChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.black,
      ),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}
