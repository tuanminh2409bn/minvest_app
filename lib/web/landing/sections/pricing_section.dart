import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
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
            children: [
              for (int i = 0; i < plans.length; i++)
                _AnimatedPricingCard(
                  plan: plans[i],
                  features: features,
                  slideDirection: i == 0
                      ? _SlideDirection.fromLeft
                      : i == 1
                          ? _SlideDirection.fromBottom
                          : _SlideDirection.fromRight,
                ),
            ],
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

enum _SlideDirection { fromLeft, fromRight, fromBottom }

class _AnimatedPricingCard extends StatefulWidget {
  final _PlanData plan;
  final List<String> features;
  final _SlideDirection slideDirection;

  const _AnimatedPricingCard({
    required this.plan,
    required this.features,
    required this.slideDirection,
  });

  @override
  State<_AnimatedPricingCard> createState() => _AnimatedPricingCardState();
}

class _AnimatedPricingCardState extends State<_AnimatedPricingCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    final beginOffset = switch (widget.slideDirection) {
      _SlideDirection.fromLeft => const Offset(-0.18, 0),
      _SlideDirection.fromRight => const Offset(0.18, 0),
      _ => const Offset(0, 0.18),
    };
    _slide = Tween(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('pricing_card_${widget.plan.title}'),
      onVisibilityChanged: (info) {
        if (!_hasPlayed && info.visibleFraction > 0.15) {
          _hasPlayed = true;
          _controller.forward();
        }
      },
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: _PricingCardContent(
            plan: widget.plan,
            features: widget.features,
          ),
        ),
      ),
    );
  }
}

class _AnimatedBorderCard extends StatefulWidget {
  final Widget child;
  const _AnimatedBorderCard({required this.child});

  @override
  State<_AnimatedBorderCard> createState() => _AnimatedBorderCardState();
}

class _AnimatedBorderCardState extends State<_AnimatedBorderCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final colors = const [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)];
        final stops = [
          (t + 0.0) % 1,
          (t + 0.4) % 1,
          (t + 0.8) % 1,
        ]..sort();
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              stops: stops,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: colors[1].withOpacity(0.25),
                blurRadius: 22,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _PricingCardContent extends StatelessWidget {
  final _PlanData plan;
  final List<String> features;
  const _PricingCardContent({required this.plan, required this.features});

  @override
  Widget build(BuildContext context) {
    return _AnimatedBorderCard(
      child: Container(
        width: 300,
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
