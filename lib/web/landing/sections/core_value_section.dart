import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/text_styles.dart';

class CoreValueSection extends StatelessWidget {
  const CoreValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        title: 'Real-Time Market Analysis',
        desc:
            'Our AI monitors the market continuously, identifying technical convergence zones and reliable breakout points – so you can enter trades at the right moment.'
      ),
      (
        title: 'Save Time on Analysis',
        desc:
            'No more hours spent reading charts. Receive tailored investment strategies in just minutes a day.'
      ),
      (
        title: 'Minimize Emotional Trading',
        desc:
            'With smart alerts, risk detection, and data-driven signals – not emotions – you stay disciplined and in control of every decision.'
      ),
      (
        title: 'Seize Every Opportunity',
        desc:
            'Timely strategy updates delivered straight to your inbox ensure you ride market trends at the perfect time.'
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        children: [
          Text(
            'Minvest AI- Core value',
            style: AppTextStyles.h1.copyWith(fontSize: 36, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'AI analyzes real-time market data continuously, filtering insights to identify fast, accurate investment opportunities',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: items
                .map(
                  (item) => _CoreValueCard(
                    title: item.title,
                    description: item.desc,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _CoreValueCard extends StatelessWidget {
  final String title;
  final String description;

  const _CoreValueCard({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      constraints: const BoxConstraints(minHeight: 200),
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4779D4),
            Color(0xFF3E42BD),
            Color(0xFFC812E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.h3.copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
