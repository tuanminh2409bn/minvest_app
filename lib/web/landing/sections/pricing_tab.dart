import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/gradients.dart';

class PricingTab extends StatefulWidget {
  const PricingTab({super.key});
  @override
  State<PricingTab> createState() => _PricingTabState();
}

class _PricingTabState extends State<PricingTab> {
  bool _isAnnual = false;

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

    final String price = _isAnnual ? '\$460' : '\$78';
    final String? oldPrice = _isAnnual ? '\$920' : null;

    final plans = [
      _PlanData(
        title: 'GOLD',
        price: price,
        oldPrice: oldPrice,
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
        price: price,
        oldPrice: oldPrice,
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
        price: price,
        oldPrice: oldPrice,
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
        _BillingToggle(
          isAnnual: _isAnnual,
          onChanged: (value) => setState(() => _isAnnual = value),
        ),
        const SizedBox(height: 32),
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
    );
  }
}

class _BillingToggle extends StatelessWidget {
  final bool isAnnual;
  final ValueChanged<bool> onChanged;
  const _BillingToggle({required this.isAnnual, required this.onChanged});

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
        children: [
          _ToggleItem(label: 'Monthly', selected: !isAnnual, onTap: () => onChanged(false)),
          _ToggleItem(label: 'Annually', selected: isAnnual, onTap: () => onChanged(true)),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ToggleItem({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _PlanData {
  final String title;
  final String price;
  final String? oldPrice;
  final LinearGradient gradient;
  final LinearGradient borderGradient;
  const _PlanData({
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.gradient,
    required this.borderGradient,
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
    _fade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('pricing_tab_${widget.plan.title}'),
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
          child: _PricingCardContent(plan: widget.plan, features: widget.features),
        ),
      ),
    );
  }
}

class _AnimatedBorderCard extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  const _AnimatedBorderCard({required this.child, required this.colors});

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
        final stops = [
          (t + 0.0) % 1,
          (t + 0.5) % 1,
        ]..sort();
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
              stops: stops,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: widget.colors.first.withOpacity(0.25),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 12),
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
      colors: plan.borderGradient.colors,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
            if (plan.oldPrice != null && plan.oldPrice!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  plan.oldPrice!,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white54,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
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
