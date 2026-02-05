import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    // Sử dụng màu xanh dương sáng chung cho hiệu ứng glow
    const commonGlowColor = Color(0xFF00BFFF); 

    return [
      _PlanData(
        id: 'gold$suffix',
        title: 'GOLD',
        price: price,
        oldPrice: oldPrice,
        badge: badge,
        glowColor: commonGlowColor,
      ),
      _PlanData(
        id: 'forex$suffix',
        title: 'FOREX',
        price: price,
        oldPrice: oldPrice,
        badge: badge,
        glowColor: commonGlowColor,
      ),
      _PlanData(
        id: 'crypto$suffix',
        title: 'CRYPTO',
        price: price,
        oldPrice: oldPrice,
        badge: badge,
        glowColor: commonGlowColor,
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
          textScaler: isMobile ? const TextScaler.linear(0.9) : const TextScaler.linear(1.0),
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
  final Color glowColor;

  const _PlanData({
    required this.id,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.badge,
    required this.glowColor,
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
    const beginOffset = Offset(0, 0.18); // Tất cả đều trượt lên
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
    return RepaintBoundary(
      child: VisibilityDetector(
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
    ));
  }
}

class _StaticBorderCard extends StatelessWidget {
  final Widget child;
  const _StaticBorderCard({required this.child});

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)];
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: colors,
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
  // Logic mua hàng đã bị loại bỏ theo yêu cầu

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;
    final appLocalizations = AppLocalizations.of(context)!;
    final currentLang = Localizations.localeOf(context).languageCode;
    final bool isFullText = currentLang == 'en' || currentLang == 'vi';

    // Figma: 658px
    final double minCardHeight = isMobile ? 658 : 658; 
    final double verticalPadding = isMobile ? 48 : 64; 

    return _StaticBorderCard(
      child: Container(
        constraints: BoxConstraints(minHeight: minCardHeight),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(6),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 1.5,
                    colors: [
                      widget.plan.glowColor.withOpacity(0.15), // Opacity mờ
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 24 : AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minCardHeight - verticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Dàn trải nội dung
                  children: [
                    // Phần 1: Header và Giá
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.crown, color: Colors.white, size: isMobile ? 32 : 26),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.plan.title, 
                                style: AppTextStyles.h3.copyWith(
                                  color: Colors.white, 
                                  fontSize: isMobile ? 28 : 24,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: isMobile ? 1.0 : 2.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _saveBadge(widget.plan.badge, isMobile),
                          ],
                        ),
                        SizedBox(height: isMobile ? 32 : 32),
                        Text(
                          widget.plan.price, 
                          style: AppTextStyles.h1.copyWith(
                            fontSize: isMobile ? 68 : 48, 
                            color: const Color(0xFF00B2FF),
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.6,
                          ),
                        ),
                        if (widget.plan.oldPrice != null && widget.plan.oldPrice!.isNotEmpty)
                          Text(
                            widget.plan.oldPrice!,
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white54,
                              decoration: TextDecoration.lineThrough,
                              fontSize: isMobile ? 38 : 28,
                            ),
                          ),
                      ],
                    ),

                    // Phần 2: Danh sách tính năng
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appLocalizations.whatsIncluded, 
                          style: AppTextStyles.body.copyWith(
                            color: Colors.white70,
                            fontSize: isMobile ? 18 : 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...widget.features.map((f) => _feature(f, isMobile)).toList(),
                      ],
                    ),

                    // Phần 3: Nút đăng ký (Figma: 368x55)
                    SizedBox(
                      width: double.infinity,
                      height: 55, // Cố định chiều cao
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), // Bo góc 6px theo Figma
                          padding: EdgeInsets.zero, // Reset padding mặc định
                        ),
                        onPressed: () {
                          if (FirebaseAuth.instance.currentUser == null) {
                            Navigator.of(context).pushNamed('/signup');
                          } else {
                            // Logic cho người dùng đã đăng nhập (nếu có)
                          }
                        }, 
                        child: Text(
                                appLocalizations.chooseThisPlan,
                                style: AppTextStyles.bodyBold.copyWith(
                                  color: Colors.black,
                                  fontSize: 18, // Font 18
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.54,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _saveBadge(String text, bool isMobile, {bool useEllipsis = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 16, 
        vertical: isMobile ? 12 : 8
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF289EFF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        overflow: useEllipsis ? TextOverflow.ellipsis : null,
        maxLines: 1,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white, 
          fontWeight: FontWeight.w700,
          fontSize: isMobile ? 18 : 14, // Tăng kích thước chữ
        ),
      ),
    );
  }

  Widget _feature(String text, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Căn lên trên cùng
        children: [
          // Ô tích màu trắng với dấu tích màu xanh dương
          Container(
            margin: const EdgeInsets.only(top: 3), // Căn chỉnh nhỏ để khớp với dòng chữ đầu tiên
            width: isMobile ? 18 : 16,
            height: isMobile ? 18 : 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Icon(
              Icons.check,
              color: const Color(0xFF289EFF),
              size: isMobile ? 16 : 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: isMobile ? 18 : 15, // Tăng kích thước chữ
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
