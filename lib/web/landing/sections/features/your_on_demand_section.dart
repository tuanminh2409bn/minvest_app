import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../theme/text_styles.dart';

class YourOnDemandSection extends StatelessWidget {
  const YourOnDemandSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 96),
        Column(
          children: [
            Text(
              'Your On-Demand Financial Expert',
              style: AppTextStyles.h1.copyWith(fontSize: 26, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'AI platform suggests trading signals - self-learning, analyses the market 24/7, unaffected by emotions. Minvest has supported over 10,000 financial analysts\nin their journey to find accurate, stable, and easy-to-apply signals.',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 150),
        SizedBox(
          height: 640,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Glow
              Positioned.fill(
                child: IgnorePointer(
                  child: Transform.scale(
                    scaleX: 1.8,
                    scaleY: 1.3,
                    child: Opacity(
                      opacity: 0.9,
                      child: Image.asset(
                        'assets/mockups/light.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ),
              // Laptop
              Positioned(
                bottom: -30,
                child: SizedBox(
                  width: 1100,
                  child: Image.asset(
                    'assets/mockups/laptop.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Cards
              Positioned(
                top: 160,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        _InfoCard(text: 'AI-Powered Trading Signal Platform'),
                        SizedBox(width: 16),
                        _InfoCard(text: 'Self-Learning Systems, Sharper Insights, Stronger Trades'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        _InfoCard(text: 'Emotionless Execution For Smarter,\nMore Disciplined Trading'),
                        SizedBox(width: 16),
                        _InfoCard(text: 'Analysing the market 24/7'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String text;
  const _InfoCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      height: 118,
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(9),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
