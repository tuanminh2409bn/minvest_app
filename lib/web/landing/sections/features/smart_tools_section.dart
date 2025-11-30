import 'package:flutter/material.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/spacing.dart';

class SmartToolsSection extends StatelessWidget {
  const SmartToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            'Smarter Tools - Better Investments',
            style: AppTextStyles.h1.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Discover the features that help you minimize risks, seize opportunities, and grow your wealth.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Background gradient bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0C132A), Color(0xFF0A0E1F)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: const [
                Icon(Icons.circle, size: 10, color: Colors.white24),
                SizedBox(width: 8),
                Icon(Icons.circle, size: 10, color: Colors.white24),
                SizedBox(width: 8),
                Icon(Icons.circle, size: 10, color: Colors.white24),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Main card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.circle, size: 10, color: Colors.white30),
                      SizedBox(width: 6),
                      Icon(Icons.circle, size: 10, color: Colors.white30),
                      SizedBox(width: 6),
                      Icon(Icons.circle, size: 10, color: Colors.white30),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Colors.white12),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Performance Overview',
                        style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Our multi-market AI scans Forex, Crypto, and Metals in real-time, delivering expert-validated trading signals - with clear entry, stop-loss, and take-profit levels.',
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: const [
                          _StatCard(
                            title: 'Total Profit',
                            value: '9,250.8 pips',
                          ),
                          SizedBox(width: 16),
                          _StatCard(
                            title: 'Completion signal',
                            value: '507',
                          ),
                          SizedBox(width: 16),
                          _StatCard(
                            title: 'Win Rate',
                            value: '62.7%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Text(
                value,
                style: AppTextStyles.h1.copyWith(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF00BFFF)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
