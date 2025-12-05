import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';

class PricingSection extends StatefulWidget {
  final String heading;
  final String subheading;
  final double headingFontSize;

  const PricingSection({
    super.key,
    this.heading = 'Best Prices for Premium Access',
    this.subheading = 'Choose a plan that fits your business needs and start automating with AI',
    this.headingFontSize = 28,
  });

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  bool _isAnnual = true;

  List<_PlanData> _buildPlans() {
    final price = _isAnnual ? '\$460' : '\$78';
    final oldPrice = _isAnnual ? '\$920' : null;
    return [
      _PlanData(
        title: 'GOLD',
        price: price,
        oldPrice: oldPrice,
        badge: 'SAVE 50%',
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFF7B61FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _PlanData(
        title: 'FOREX',
        price: price,
        oldPrice: oldPrice,
        badge: 'SAVE 50%',
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFF7B61FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _PlanData(
        title: 'CRYPTO',
        price: price,
        oldPrice: oldPrice,
        badge: 'SAVE 50%',
        gradient: const LinearGradient(
          colors: [Color(0xFFB81EE3), Color(0xFF0ED4FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final plans = _buildPlans();

    const features = [
      'Includes Entry, SL, TP',
      'Detailed analysis and evaluation of each signal',
      'Signal performance statistics',
      'Real-time notifications via email',
      'Continuously updating market data 24/7',
      'Providing the best signals in real time',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.heading,
            style: AppTextStyles.h1.copyWith(fontSize: widget.headingFontSize, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.subheading,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          _toggle(),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: plans
                .map((plan) => _PricingCard(
                      plan: plan,
                      features: features,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _toggle() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleItem(
            'Monthly',
            selected: !_isAnnual,
            onTap: () => setState(() => _isAnnual = false),
          ),
          _toggleItem(
            'Annually',
            selected: _isAnnual,
            onTap: () => setState(() => _isAnnual = true),
          ),
        ],
      ),
    );
  }

  Widget _toggleItem(String text, {required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: selected
              ? const LinearGradient(
                  colors: [Color(0xFF00BFFF), Color(0xFFD500F9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : Colors.black,
        ),
        child: Text(
          text,
          style: AppTextStyles.body.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PlanData {
  final String title;
  final String price;
  final String? oldPrice;
  final String badge;
  final LinearGradient gradient;

  const _PlanData({
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.badge,
    required this.gradient,
  });
}

class _PricingCard extends StatelessWidget {
  final _PlanData plan;
  final List<String> features;

  const _PricingCard({
    required this.plan,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: plan.gradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.workspace_premium, color: Colors.white, size: 22),
                const SizedBox(width: 8),
                Text(plan.title, style: AppTextStyles.h3.copyWith(color: Colors.white)),
                const Spacer(),
                _saveBadge(plan.badge),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(plan.price, style: AppTextStyles.h1.copyWith(fontSize: 34, color: const Color(0xFF00B2FF))),
            if (plan.oldPrice != null && plan.oldPrice!.isNotEmpty)
              Text(
                plan.oldPrice!,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white54,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            const SizedBox(height: AppSpacing.md),
            Text("What's included:", style: AppTextStyles.body.copyWith(color: Colors.white70)),
            const SizedBox(height: AppSpacing.sm),
            ...features.map((f) => _feature(f)).toList(),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _saveBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2A3E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _feature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_box, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
