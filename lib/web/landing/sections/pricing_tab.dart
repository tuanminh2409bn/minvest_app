import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';
import '../../theme/gradients.dart';

class PricingTab extends StatelessWidget {
  const PricingTab({super.key});

  @override
  Widget build(BuildContext context) {
    const features = [
      'Includes Entry, SL, TP',
      'Detailed analysis and evaluation of each signal',
      'Signal performance statistics',
      'Real-time notifications via email',
      'Continuously updating market data 24/7',
      'Providing the best signals in real time',
    ];

    final plans = [
      _PlanData(
        title: 'GOLD',
        price: '\$78',
        gradient: const LinearGradient(
          colors: [Color(0xFF131629), Color(0xFF0A0C18)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderGradient: const LinearGradient(
          colors: [Color(0xFFB95BF8), Color(0xFF00B2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _PlanData(
        title: 'FOREX',
        price: '\$78',
        gradient: const LinearGradient(
          colors: [Color(0xFF131629), Color(0xFF0A0C18)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderGradient: const LinearGradient(
          colors: [Color(0xFFB95BF8), Color(0xFF00B2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _PlanData(
        title: 'CRYPTO',
        price: '\$78',
        gradient: const LinearGradient(
          colors: [Color(0xFF131629), Color(0xFF0A0C18)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderGradient: const LinearGradient(
          colors: [Color(0xFFB95BF8), Color(0xFF00B2FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        _BillingToggle(),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: plans
              .map(
                (plan) => _PricingCard(
                  plan: plan,
                  features: features,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _BillingToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _ToggleItem(label: 'Monthly', selected: true),
          _ToggleItem(label: 'Annually', selected: false),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String label;
  final bool selected;
  const _ToggleItem({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: selected ? AppGradients.cta : null,
        color: selected ? null : Colors.black,
      ),
      child: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PlanData {
  final String title;
  final String price;
  final LinearGradient gradient;
  final LinearGradient borderGradient;
  const _PlanData({
    required this.title,
    required this.price,
    required this.gradient,
    required this.borderGradient,
  });
}

class _PricingCard extends StatelessWidget {
  final _PlanData plan;
  final List<String> features;
  const _PricingCard({required this.plan, required this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: plan.borderGradient,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          gradient: plan.gradient,
        ),
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.workspace_premium_outlined, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  plan.title,
                  style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              plan.price,
              style: AppTextStyles.h1.copyWith(color: const Color(0xFF13A2FF), fontSize: 34, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Text(
              "What's included:",
              style: AppTextStyles.body.copyWith(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 10),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_box, color: Colors.white70, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        f,
                        style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: AppTextStyles.body.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {},
                child: const Text('Choose this plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
