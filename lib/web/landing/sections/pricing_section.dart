import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/core/services/paypal_service_web.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';

class PricingSection extends StatefulWidget {
  final String? heading;
  final String? subheading;
  final double headingFontSize;

  const PricingSection({
    super.key,
    this.heading,
    this.subheading,
    this.headingFontSize = 32,
  });

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  bool _isAnnual = true;

  List<_PlanData> _buildPlans(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final price = _isAnnual ? '\$460' : '\$78';
    final oldPrice = _isAnnual ? '\$920' : null;
    final badge = appLocalizations.save50Percent;
    final suffix = _isAnnual ? '_12_months' : '_1_month';
    return [
      _PlanData(
        id: 'gold$suffix',
        title: 'GOLD',
        price: price,
        oldPrice: oldPrice,
        badge: badge,
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFF7B61FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _PlanData(
        id: 'forex$suffix',
        title: 'FOREX',
        price: price,
        oldPrice: oldPrice,
        badge: badge,
        gradient: const LinearGradient(
          colors: [Color(0xFF00BFFF), Color(0xFF7B61FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      _PlanData(
        id: 'crypto$suffix',
        title: 'CRYPTO',
        price: price,
        oldPrice: oldPrice,
        badge: badge,
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    final appLocalizations = AppLocalizations.of(context)!;
    final plans = _buildPlans(context);
    final heading = widget.heading ?? appLocalizations.bestPricesForPremiumAccess;
    final subheading = widget.subheading ?? appLocalizations.choosePlanFitsNeeds;

    final features = [
      appLocalizations.includesEntrySlTp,
      appLocalizations.detailedAnalysis,
      appLocalizations.signalPerformanceStats,
      appLocalizations.continuouslyUpdating,
      appLocalizations.providingBestSignals,
    ];

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
        ),
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              heading,
              style: AppTextStyles.h1.copyWith(fontSize: widget.headingFontSize, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
                      Text(
                        subheading,
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white, 
                          fontSize: isMobile ? 18 : 16,
                        ),
                        textAlign: TextAlign.center,
                      ),            const SizedBox(height: AppSpacing.lg),
            _toggle(context),
            const SizedBox(height: AppSpacing.lg),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int i = 0; i < plans.length; i++) ...[
                          if (i > 0) const SizedBox(width: 16),
                          Expanded(
                            child: _AnimatedPricingCard(
                              plan: plans[i],
                              features: features,
                              slideDirection: i == 0
                                  ? _SlideDirection.fromLeft
                                  : i == 1
                                      ? _SlideDirection.fromBottom
                                      : _SlideDirection.fromRight,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      for (int i = 0; i < plans.length; i++) ...[
                        if (i > 0) const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: _AnimatedPricingCard(
                            plan: plans[i],
                            features: features,
                            slideDirection: _SlideDirection.fromBottom,
                          ),
                        ),
                      ],
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggle(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
            appLocalizations.monthly,
            selected: !_isAnnual,
            onTap: () => setState(() => _isAnnual = false),
          ),
          _toggleItem(
            appLocalizations.annually,
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
  final String id;
  final String title;
  final String price;
  final String? oldPrice;
  final String badge;
  final LinearGradient gradient;

  const _PlanData({
    required this.id,
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
            borderRadius: BorderRadius.circular(6),
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

class _PricingCardContent extends StatefulWidget {
  final _PlanData plan;
  final List<String> features;
  const _PricingCardContent({required this.plan, required this.features});

  @override
  State<_PricingCardContent> createState() => _PricingCardContentState();
}

class _PricingCardContentState extends State<_PricingCardContent> {
  bool _isLoading = false;

  Future<void> _handlePurchase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushNamed('/signin');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final paypalService = PaypalServiceWeb();
      final orderID = await paypalService.createOrder(widget.plan.id);

      if (orderID != null && mounted) {
        // Show dialog to wait for user confirmation
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text("Completing Payment", style: TextStyle(color: Colors.white)),
            content: const Text(
              "A PayPal window has been opened. Please complete the payment there.\n\nAfter you have paid, click 'I Have Paid' below.",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0070BA)), // PayPal Blue
                onPressed: () {
                  Navigator.pop(ctx);
                  _verifyPayment(orderID);
                },
                child: const Text("I Have Paid", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyPayment(String orderID) async {
    setState(() => _isLoading = true);
    try {
      final success = await PaypalServiceWeb().captureOrder(orderID);
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Successful! Your account has been upgraded.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Payment Verification Failed or Incomplete.')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error verifying: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;
    final appLocalizations = AppLocalizations.of(context)!;
    final double cardHeight = isMobile ? 500 : 450;

    return _AnimatedBorderCard(
      child: Container(
        width: double.infinity,
        height: isMobile ? cardHeight : null,
        constraints: BoxConstraints(minHeight: cardHeight),
        padding: EdgeInsets.all(isMobile ? 24 : AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.workspace_premium, color: Colors.white, size: isMobile ? 28 : 22),
                    const SizedBox(width: 8),
                    Text(
                      widget.plan.title, 
                      style: AppTextStyles.h3.copyWith(
                        color: Colors.white, 
                        fontSize: isMobile ? 36 : 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    _saveBadge(widget.plan.badge),
                  ],
                ),
                SizedBox(height: isMobile ? 24 : AppSpacing.md),
                Text(
                  widget.plan.price, 
                  style: AppTextStyles.h1.copyWith(
                    fontSize: isMobile ? 72 : 34, 
                    color: const Color(0xFF00B2FF),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                if (widget.plan.oldPrice != null && widget.plan.oldPrice!.isNotEmpty)
                  Text(
                    widget.plan.oldPrice!,
                    style: AppTextStyles.body.copyWith(
                      color: Colors.white54,
                      decoration: TextDecoration.lineThrough,
                      fontSize: isMobile ? 22 : 14,
                    ),
                  ),
                SizedBox(height: isMobile ? 28 : AppSpacing.md),
                Text(
                  appLocalizations.whatsIncluded, 
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white70,
                    fontSize: isMobile ? 22 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...widget.features.map((f) => _feature(f, isMobile)).toList(),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 18 : 12),
                ),
                onPressed: _isLoading ? null : _handlePurchase,
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                    : Text(
                        appLocalizations.chooseThisPlan,
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
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

  Widget _feature(String text, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_box, color: Colors.white70, size: isMobile ? 20 : 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: isMobile ? 20 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
