import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'dart:convert';
import '../theme/colors.dart';
import '../theme/breakpoints.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import 'widgets/navbar.dart';
import 'widgets/gradient_button.dart';
import 'widgets/orb_effect.dart';
import 'sections/pricing_section.dart';
import 'sections/footer_section.dart';
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: const WebChatBubble(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: LayoutBuilder(
        builder: (context, constraints) {
          try {
            // Debug check for localization
            if (AppLocalizations.of(context) == null) {
              throw Exception("AppLocalizations is null!");
            }

            final isTablet = constraints.maxWidth < Breakpoints.desktop &&
                constraints.maxWidth >= Breakpoints.tablet;
            final isMobile = constraints.maxWidth < Breakpoints.tablet;
            final horizontalPadding = isMobile
                ? 16.0
                : isTablet
                    ? 24.0
                    : 32.0;
            final double sectionSpacing = isMobile ? 60.0 : 100.0;

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: isMobile
                    ? const TextScaler.linear(0.72)
                    : const TextScaler.linear(1.0),
              ),
              child: Container(
                color: AppColors.background,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 12),
                            LandingNavBar(),
                            const HeroSection(),
                            SizedBox(height: sectionSpacing),
                            const HeroSubtitleSection(),
                            SizedBox(height: sectionSpacing),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final bool isNarrow =
                                    constraints.maxWidth < 900;
                                if (isNarrow) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: const [
                                      LiveSignalsSection(),
                                      SizedBox(height: 24),
                                      HeroSignalsSection(),
                                    ],
                                  );
                                }
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Expanded(child: HeroSignalsSection()),
                                    SizedBox(width: 16),
                                    Expanded(child: LiveSignalsSection()),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: sectionSpacing),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final bool isNarrow =
                                    constraints.maxWidth < 900;
                                if (isNarrow) {
                                  return Column(
                                    children: [
                                      const OrderEngineSection(),
                                      SizedBox(height: sectionSpacing),
                                      const _TransparentCardAnimated(),
                                      const SizedBox(height: 8),
                                      const _SignalsPerformanceCard(),
                                    ],
                                  );
                                }
                                return Column(
                                  children: const [
                                    OrderEngineSection(),
                                    SizedBox(height: 72),
                                    _SignalsPerformanceRow(),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: sectionSpacing),
                            const CoreValueSection(),
                            SizedBox(height: sectionSpacing),
                            const PricingSection(),
                            SizedBox(height: sectionSpacing),
                            const FaqSection(),
                            SizedBox(height: sectionSpacing),
                            const CtaSection(),
                            SizedBox(height: sectionSpacing),
                            const FooterSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } catch (e, stackTrace) {
            print("CRASH in LandingPage: $e\n$stackTrace");
            return Center(
              child: SelectableText(
                "Error rendering LandingPage:\n$e",
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isNarrow = constraints.maxWidth < 720;
      final double heroHeight = isNarrow ? 620 : 760;
      final Size baseSize = Size(constraints.maxWidth, heroHeight);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ClipRect(
          child: SizedBox(
            width: double.infinity,
            height: heroHeight,
            child: _HeroInteractive(
              enableHover: !isNarrow,
              baseSize: baseSize,
              expandToWidth: false,
            ),
          ),
        ),
      );
    });
  }
}

class _HeroInteractive extends StatefulWidget {
  final bool enableHover;
  final Size baseSize;
  final bool expandToWidth;
  const _HeroInteractive(
      {super.key,
      this.enableHover = true,
      this.baseSize = const Size(1200, 800),
      this.expandToWidth = false});
  @override
  State<_HeroInteractive> createState() => _HeroInteractiveState();
}

class _HeroInteractiveState extends State<_HeroInteractive>
    with SingleTickerProviderStateMixin {
  Offset _pointer = Offset.zero;
  late final AnimationController _contentController;
  late final Animation<Offset> _titleSlide;
  late final Animation<Offset> _titleSlideUp;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<Offset> _subtitleSlideUp;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _ctaSlide;
  late final Animation<double> _ctaFade;
  final bool _contentPlayed = false;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    
    // Desktop Horizontal Slides
    _titleSlide =
        Tween(begin: const Offset(-0.12, 0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic)),
    );
    _subtitleSlide =
        Tween(begin: const Offset(-0.08, 0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.15, 0.7, curve: Curves.easeOutCubic)),
    );

    // Mobile Vertical Slides (Nổi lên)
    _titleSlideUp =
        Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic)),
    );
    _subtitleSlideUp =
        Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.15, 0.7, curve: Curves.easeOutCubic)),
    );

    _titleFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.0, 0.55, curve: Curves.easeOut)),
    );
    
    _subtitleFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.15, 0.7, curve: Curves.easeOut)),
    );
    
    // CTA is already sliding up, can reuse for both
    _ctaSlide = Tween(begin: const Offset(0, 0.16), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic)),
    );
    _ctaFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.35, 1.0, curve: Curves.easeOut)),
    );

    // Start animation immediately since this is the Hero section (Above the fold)
    // Avoiding VisibilityDetector here prevents "invisible content" issues on initial load
    _contentController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.baseSize;
    final viewportWidth = MediaQuery.of(context).size.width;
    final bool isMobile = viewportWidth < Breakpoints.tablet;
    final double targetWidth = widget.expandToWidth
        ? viewportWidth
        : viewportWidth.clamp(320, math.max(320.0, size.width));
    final double scaleFactor = targetWidth / size.width;
    
    final content = SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Thay thế _buildBlob bằng OrbEffect
          const Positioned.fill(child: OrbEffect()),

          // Lớp bắt sự kiện chuột (Catcher)
          Positioned.fill(
            child: MouseRegion(
              hitTestBehavior: HitTestBehavior.opaque, // Bắt sự kiện chắc chắn
              onHover: (event) {
                // Logic tính toán tọa độ
                final width = size.width;
                final height = size.height;
                final minSize = math.min(width, height);
                final centerX = width / 2;
                final centerY = height / 2;

                // Vì MouseRegion nằm trong SizedBox(size), local position chính là tọa độ trong khung 1200x800
                final local = event.localPosition;

                final uvX = ((local.dx - centerX) / minSize) * 2.0;
                final uvY = ((local.dy - centerY) / minSize) * 2.0;

                final iframe = web.document.getElementById('orb-iframe')
                    as web.HTMLIFrameElement?;
                if (iframe != null && iframe.contentWindow != null) {
                  final jsonStr = jsonEncode({'uvX': uvX, 'uvY': uvY});
                  iframe.contentWindow!.postMessage(jsonStr.toJS, '*'.toJS);
                }

                setState(() {
                  _pointer = Offset(
                    (local.dx / width - 0.5).clamp(-1, 1),
                    (local.dy / height - 0.5).clamp(-1, 1),
                  );
                });
              },
              onExit: (_) {
                final iframe = web.document.getElementById('orb-iframe')
                    as web.HTMLIFrameElement?;
                if (iframe != null && iframe.contentWindow != null) {
                  iframe.contentWindow!
                      .postMessage('mouseleave'.toJS, '*'.toJS);
                }
                setState(() => _pointer = Offset.zero);
              },
              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned.fill(
            child: VisibilityDetector(
              key: const Key('hero_content_visibility'),
              onVisibilityChanged: (info) {
                 if (!_contentPlayed && info.visibleFraction > 0.1) {
                   if (_contentController.status == AnimationStatus.dismissed) {
                      _contentController.forward();
                   }
                 }
              },
              child: _buildContent(isMobile),
            ),
          ),
        ],
      ),
    );

    final scaled = Transform.scale(scale: scaleFactor, child: content);

    if (!widget.enableHover) {
      return scaled;
    }

    return scaled;
  }

  Widget _buildContent(bool isMobile) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedWidget(
              slideAnim: isMobile ? _titleSlideUp : _titleSlide,
              fadeAnim: _titleFade,
              child: Text(
                AppLocalizations.of(context)!.heroTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(fontSize: 44),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildAnimatedWidget(
              slideAnim: isMobile ? _subtitleSlideUp : _subtitleSlide,
              fadeAnim: _subtitleFade,
              child: Text(
                AppLocalizations.of(context)!.heroSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.h3.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildAnimatedWidget(
              slideAnim: _ctaSlide, // CTA is always vertical slide up
              fadeAnim: _ctaFade,
              child: Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  alignment: WrapAlignment.center,
                  children: [
                    GradientButton(
                      label: AppLocalizations.of(context)!.getSignalsNow,
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 24 : 32,
                          vertical: isMobile ? 12 : 14),
                      borderRadius: isMobile ? 1 : 6,
                      textStyle: AppTextStyles.body.copyWith(
                        fontSize: isMobile ? 20 : 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.1,
                      ),
                      onPressed: () {
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.of(context).pushNamed('/ai-signals');
                        } else {
                          Navigator.of(context).pushNamed('/signup');
                        }
                      },
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(isMobile ? 1 : 8),
                      onTap: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState.status == AuthStatus.authenticated) {
                          Navigator.of(context).pushNamed('/ai-signals');
                        } else {
                          Navigator.of(context).pushNamed('/signin');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(isMobile ? 1 : 8),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF04B3E9),
                              Color(0xFF2E60FF),
                              Color(0xFFD500F9)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(isMobile ? 1 : 7),
                            color: Colors.black,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 32,
                            vertical: isMobile
                                ? 11
                                : 13, // Reduced by 1 to match GradientButton (which has no border)
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.freeTrial,
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: isMobile ? 20 : 16,
                              height: 1.1, // Sync with GradientButton
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedWidget({
    required Animation<Offset> slideAnim,
    required Animation<double> fadeAnim,
    required Widget child,
  }) {
    // Always use SlideTransition for "Nổi lên" effect (Vertical slide)
    return SlideTransition(
      position: slideAnim,
      child: FadeTransition(opacity: fadeAnim, child: child),
    );
  }

  Matrix4 _addSkew(Matrix4 matrix, double skewX, double skewY) {
    final skewMatrix = Matrix4(
      1,
      skewX,
      0,
      0,
      skewY,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
    );
    return matrix..multiply(skewMatrix);
  }
}

class HeroSubtitleSection extends StatelessWidget {
  const HeroSubtitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return _RevealOnScroll(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.globalAiInnovationTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(
                fontSize: isMobile ? 32 : 28,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppLocalizations.of(context)!.globalAiInnovationDesc,
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: isMobile ? 18 : 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroSignalsSection extends StatefulWidget {
  const HeroSignalsSection({super.key});

  @override
  State<HeroSignalsSection> createState() => _HeroSignalsSectionState();
}

class _HeroSignalsSectionState extends State<HeroSignalsSection>

    with SingleTickerProviderStateMixin {

  late final AnimationController _entranceController;

  late final Animation<Offset> _slideIn;

  late final Animation<Offset> _slideUp;

  late final Animation<double> _fadeIn;

  bool _hasPlayed = false;



  @override

  void initState() {

    super.initState();

    _entranceController = AnimationController(

      vsync: this,

      duration: const Duration(milliseconds: 950),

    );

    _slideIn = Tween(begin: const Offset(-0.2, 0), end: Offset.zero).animate(

      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),

    );

    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(

      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),

    );

    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(

      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),

    );

  }



  @override

  void dispose() {

    _entranceController.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    final isMobile = width < Breakpoints.tablet;



    return LayoutBuilder(

      builder: (context, constraints) {

        final maxWidth = constraints.maxWidth.clamp(320.0, 560.0);

        return Center(

          child: VisibilityDetector(

            key: const Key('hero_signals_visibility'),

            onVisibilityChanged: (info) {

              if (!_hasPlayed && info.visibleFraction > 0.2) {

                _hasPlayed = true;

                _entranceController.forward();

              }

            },

            child: SlideTransition(

              position: isMobile ? _slideUp : _slideIn,

              child: FadeTransition(

                opacity: _fadeIn,

                child: _AnimatedGlowCard(

                  width: maxWidth,

                  child: Container(

                    constraints: BoxConstraints(minHeight: isMobile ? 0 : 520),

                    padding: EdgeInsets.all(isMobile ? 16 : AppSpacing.md),

                    child: Column(

                      mainAxisSize: MainAxisSize.min,

                      mainAxisAlignment: isMobile

                          ? MainAxisAlignment.start

                          : MainAxisAlignment.spaceBetween,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            _buildSearchBar(context),

                            const SizedBox(height: AppSpacing.md),

                            _buildTabs(context),

                          ],

                        ),

                        if (isMobile) const SizedBox(height: 24),

                        const _StaggeredSignalCards(),

                      ],

                    ),

                  ),

                ),

              ),

            ),

          ),

        );

      },

    );

  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        AppLocalizations.of(context)!.aiSignal,
        style: AppTextStyles.body
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    Widget tab(String text, {bool active = false}) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF2B2B2B) : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        tab('Gold', active: true),
        const SizedBox(width: AppSpacing.sm),
        tab('Forex'),
        const SizedBox(width: AppSpacing.sm),
        tab('Crypto'),
      ],
    );
  }
}

class _AnimatedGlowCard extends StatefulWidget {
  final double width;
  final Widget child;
  const _AnimatedGlowCard({
    required this.width,
    required this.child,
  });

  @override
  State<_AnimatedGlowCard> createState() => _AnimatedGlowCardState();
}

class _AnimatedBorderCard extends StatefulWidget {
  final Widget child;
  const _AnimatedBorderCard({required this.child});

  @override
  State<_AnimatedBorderCard> createState() => _AnimatedBorderCardState();
}

class _AnimatedBorderCardState extends State<_AnimatedBorderCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
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
        final colors = const [
          Color(0xFF04B3E9),
          Color(0xFF2E60FF),
          Color(0xFFD500F9)
        ];
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _AnimatedGlowCardState extends State<_AnimatedGlowCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
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
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < Breakpoints.tablet;
        final t = _controller.value;
        final colors = const [
          Color(0xFF04B3E9),
          Color(0xFF2E60FF),
          Color(0xFFD500F9)
        ];
        final stops = [
          (t + 0.0) % 1,
          (t + 0.4) % 1,
          (t + 0.8) % 1,
        ]..sort();

        return Container(
          width: widget.width,
          padding: const EdgeInsets.all(2),
          constraints: BoxConstraints(minHeight: isMobile ? 400 : 520),
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
                color: colors[1].withOpacity(0.28),
                blurRadius: 24,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _GlowPainter(progress: t),
                    ),
                  ),
                ),
                child!,
              ],
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _GlowPainter extends CustomPainter {
  final double progress;
  _GlowPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * (0.3 + 0.4 * progress),
        size.height * (0.7 - 0.4 * progress));
    final radius = size.width * 0.9;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF2E60FF).withOpacity(0.18),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _StaggeredSignalCards extends StatefulWidget {
  const _StaggeredSignalCards();

  @override
  State<_StaggeredSignalCards> createState() => _StaggeredSignalCardsState();
}

class _StaggeredSignalCardsState extends State<_StaggeredSignalCards>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;
    final double viewportHeight = isMobile ? 280 : 370;
    return ClipRect(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final v = _controller.value;
          final first = _slidingCard(
            controllerValue: v,
            phaseOffset: 0.0,
            viewportHeight: viewportHeight,
            child: const _SignalCard(
              icon: Icons.currency_bitcoin,
              iconColor: Color(0xFF00B6FF),
              pair: 'BTC',
              date: 'June 1, 2025',
              entry: '93.000',
              sl: '93.300',
              tp1: '92.700',
              tp2: '92.500',
              badgeLabel: 'Sell Limit',
              badgeGradient: LinearGradient(
                colors: [Color(0xFFFF00FF), Color(0xFF9B00FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          );
          final second = _slidingCard(
            controllerValue: v,
            phaseOffset: 0.5,
            viewportHeight: viewportHeight,
            child: const _SignalCard(
              icon: Icons.auto_awesome,
              iconColor: Color(0xFF00B6FF),
              pair: 'XAU/USD',
              date: 'June 1, 2025',
              entry: '3020',
              sl: '3310',
              tp1: '3330',
              tp2: '3350',
              badgeLabel: 'Buy Limit',
              badgeGradient: LinearGradient(
                colors: [Color(0xFF3DA1FF), Color(0xFF2C6BFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          );
          final items = [
            (progress: (v + 0.0) % 1.0, widget: first),
            (progress: (v + 0.5) % 1.0, widget: second),
          ]..sort((a, b) => b.progress
              .compareTo(a.progress)); // progress lớn hơn vẽ sau → nằm trên

          return SizedBox(
            height: viewportHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [for (final item in items) item.widget],
            ),
          );
        },
      ),
    );
  }

  Widget _slidingCard({
    required double controllerValue,
    required double phaseOffset,
    required double viewportHeight,
    required Widget child,
  }) {
    final v = (controllerValue + phaseOffset) % 1.0;
    double opacity;
    if (v < 0.15) {
      opacity = Curves.easeIn.transform(v / 0.15);
    } else if (v > 0.85) {
      opacity = Curves.easeOut.transform((1 - v) / 0.15);
    } else {
      opacity = 1.0;
    }
    final slideT = Curves.easeInOut.transform(v);
    final travel = viewportHeight * 0.45;
    final baseOffset =
        viewportHeight * 0.12; // đẩy điểm xuất phát xuống dưới một chút
    final offsetY = (lerpDouble(travel, -travel, slideT) ?? 0) + baseOffset;
    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(0, offsetY),
        child: child,
      ),
    );
  }
}

class _SignalCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String pair;
  final String date;
  final String entry;
  final String sl;
  final String tp1;
  final String tp2;
  final String badgeLabel;
  final LinearGradient badgeGradient;

  const _SignalCard({
    required this.icon,
    required this.iconColor,
    required this.pair,
    required this.date,
    required this.entry,
    required this.sl,
    required this.tp1,
    required this.tp2,
    required this.badgeLabel,
    required this.badgeGradient,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 520;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF303030)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: iconColor, size: 28),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pair,
                            style: AppTextStyles.h3
                                .copyWith(fontSize: 22, color: Colors.white)),
                        Text(date,
                            style: AppTextStyles.body.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: badgeGradient,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      badgeLabel,
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              if (isNarrow)
                Wrap(
                  spacing: 24,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  children: [
                    _line('Entry: $entry'),
                    _line('SL : $sl'),
                    _line('TP1: $tp1'),
                    _line('TP2 : $tp2'),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line('Entry: $entry'),
                          _line('SL : $sl'),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _line('TP1: $tp1'),
                          _line('TP2 : $tp2'),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _line(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white),
      ),
    );
  }
}

class LiveSignalsSection extends StatefulWidget {
  const LiveSignalsSection({super.key});

  @override
  State<LiveSignalsSection> createState() => _LiveSignalsSectionState();
}

class _LiveSignalsSectionState extends State<LiveSignalsSection>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideIn;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;
  late final AnimationController _typeController;
  late String _fullText; // Changed to late String
  String _typedText = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fullText = AppLocalizations.of(context)!.liveTradingSignalsTitle;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _slideIn = Tween(begin: const Offset(0.18, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _typeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500))
      ..addListener(() {
        final phase = _typeController.value;
        final typingPortion =
            phase <= 0.8 ? (phase / 0.8) : 1.0; // 0-0.8 gõ, 0.8-1.0 giữ ở cuối
        final progress = (typingPortion * _fullText.length)
            .clamp(0, _fullText.length)
            .floor();
        setState(() {
          _typedText = _fullText.substring(0, progress);
        });
      })
      ..repeat(reverse: false);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Padding(
      padding: EdgeInsets.only(top: isMobile ? 0 : AppSpacing.xxl),
      child: VisibilityDetector(
        key: const Key('live_signals_visibility'),
        onVisibilityChanged: (info) {
          if (!_hasPlayed && info.visibleFraction > 0.2) {
            _hasPlayed = true;
            _controller.forward();
          }
        },
        child: SlideTransition(
          position: isMobile ? _slideUp : _slideIn,
          child: FadeTransition(
            opacity: _fadeIn,
            child: _buildContent(isMobile),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isMobile) {
    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 480),
      padding: isMobile
          ? const EdgeInsets.only(bottom: 24)
          : const EdgeInsets.all(AppSpacing.lg),
      decoration: isMobile
          ? null
          : BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
            ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chip(context, AppLocalizations.of(context)!.aiSignal),
          const SizedBox(height: AppSpacing.lg),
          _buildTypingTitle(isMobile),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppLocalizations.of(context)!.liveTradingSignalsDesc,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 18 : 14,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: 6,
            children: [
              _outlinedChip(AppLocalizations.of(context)!.aiSignal, isMobile),
              _outlinedChip(
                  AppLocalizations.of(context)!.trendFollowing, isMobile),
              _outlinedChip(AppLocalizations.of(context)!.realtime, isMobile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypingTitle(bool isMobile) {
    // Con trỏ nhấp nháy, bắt đầu ngay từ đầu chu kỳ.
    final showCursor = (_typeController.value % 0.6) < 0.3;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: _typedText),
          TextSpan(text: showCursor ? ' |' : '  '),
        ],
      ),
      style: AppTextStyles.h1.copyWith(
          fontSize: isMobile ? 25.0 : 29, fontWeight: FontWeight.w800),
      softWrap: true,
    );
  }

  Widget _chip(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/ai-signals'),
      child: Row(
        // Added Row with mainAxisSize.min
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF04B3E9),
                  Color(0xFF2E60FF),
                  Color(0xFFD500F9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlinedChip(String text, bool isMobile) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 1 : 6),
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderEngineSection extends StatefulWidget {
  const OrderEngineSection({super.key});

  @override
  State<OrderEngineSection> createState() => _OrderEngineSectionState();
}

class _OrderEngineSectionState extends State<OrderEngineSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _leftSlide;
  late final Animation<Offset> _rightSlide;
  late final Animation<Offset> _slideUp;
  late final Animation<Offset> _slideUpDelayed;
  late final Animation<double> _leftFade;
  late final Animation<double> _rightFade;
  late final Animation<double> _fadeDelayed;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1100)); // Tăng duration một chút để thấy rõ hiệu ứng

    // Desktop Animations
    _leftSlide = Tween(begin: const Offset(-0.18, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _rightSlide = Tween(begin: const Offset(0.18, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _leftFade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _rightFade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Mobile Animations (Staggered)
    // Card 1: Xuất hiện trước (0.0 -> 0.6)
    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic)),
    );

    // Card 2: Xuất hiện sau (0.2 -> 0.8)
    _slideUpDelayed = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic)),
    );
    _fadeDelayed = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.2, 0.8, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < 900;
        final isMobile = constraints.maxWidth < Breakpoints.tablet;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 0 : (isNarrow ? 16 : 32),
            vertical: 32,
          ),
          child: VisibilityDetector(
            key: const Key('order_engine_visibility'),
            onVisibilityChanged: (info) {
              if (!_hasPlayed && info.visibleFraction > 0.15) { // Giảm ngưỡng kích hoạt để nhạy hơn trên mobile
                _hasPlayed = true;
                _controller.forward();
              }
            },
            child: isNarrow
                ? Column(
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: isMobile ? 0 : 320),
                        child: SlideTransition(
                          position: isMobile ? _slideUp : _leftSlide,
                          child: FadeTransition(
                            opacity: isMobile ? _leftFade : _leftFade, // _leftFade dùng chung cho card 1 (mobile & desktop)
                            child: const _OrderCard(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: isMobile ? 0 : 320),
                        child: SlideTransition(
                          position: isMobile ? _slideUpDelayed : _rightSlide,
                          child: FadeTransition(
                            opacity: isMobile ? _fadeDelayed : _rightFade,
                            child: const _KeyFindingsCard(),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 520, maxWidth: 560),
                            child: SizedBox(
                              width: double.infinity,
                              child: SlideTransition(
                                position: _leftSlide,
                                child: FadeTransition(
                                  opacity: _leftFade,
                                  child: const _OrderCard(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                minHeight: 520, maxWidth: 560),
                            child: SizedBox(
                              width: double.infinity,
                              child: SlideTransition(
                                position: _rightSlide,
                                child: FadeTransition(
                                  opacity: _rightFade,
                                  child: const _KeyFindingsCard(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

class _OrderCard extends StatefulWidget {
  const _OrderCard();

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> with TickerProviderStateMixin {
  late final AnimationController _typeController;
  late String _fullText; // Changed to late String
  String _typedText = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fullText = AppLocalizations.of(context)!.orderExplanationEngineTitle;
  }

  @override
  void initState() {
    super.initState();
    _typeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500))
      ..addListener(() {
        final phase = _typeController.value;
        final typingPortion =
            phase <= 0.8 ? (phase / 0.8) : 1.0; // 0-0.8 gõ, 0.8-1.0 giữ ở cuối
        final progress = (typingPortion * _fullText.length)
            .clamp(0, _fullText.length)
            .floor();
        setState(() {
          _typedText = _fullText.substring(0, progress);
        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 520),
      padding: isMobile
          ? const EdgeInsets.only(bottom: 24)
          : const EdgeInsets.all(AppSpacing.lg),
      decoration: isMobile
          ? null
          : BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chip(context),
          const SizedBox(height: AppSpacing.lg),
          _buildTypingTitle(isMobile),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppLocalizations.of(context)!.orderExplanationEngineDesc,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 18 : 14,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _pill(AppLocalizations.of(context)!.transparent, isMobile),
              _pill(AppLocalizations.of(context)!.educational, isMobile),
              _pill(AppLocalizations.of(context)!.logical, isMobile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypingTitle(bool isMobile) {
    final showCursor = (_typeController.value % 0.6) > 0.3; // blink chậm
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: _typedText),
          TextSpan(text: showCursor ? ' |' : '  '),
        ],
      ),
      style: AppTextStyles.h1.copyWith(
          fontSize: isMobile ? 27.8 : 29, fontWeight: FontWeight.w800),
      softWrap: true,
    );
  }

  Widget _chip(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/ai-signals'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF04B3E9),
                  Color(0xFF2E60FF),
                  Color(0xFFD500F9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.aiSignal,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, bool isMobile) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 1 : 6),
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransparentCardAnimated extends StatefulWidget {
  const _TransparentCardAnimated();

  @override
  State<_TransparentCardAnimated> createState() =>
      _TransparentCardAnimatedState();
}

class _TransparentCardAnimatedState extends State<_TransparentCardAnimated>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideIn;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;
  late final AnimationController _typeController;
  late String _fullText; // Changed to late String
  String _typedText = '';
  bool _typingStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fullText = AppLocalizations.of(context)!.transparentRealPerformanceTitle;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _slideIn = Tween(begin: const Offset(0.16, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _typeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4500))
      ..addListener(() {
        final phase = _typeController.value;
        final typingPortion = phase <= 0.8 ? (phase / 0.8) : 1.0;
        final progress = (typingPortion * _fullText.length)
            .clamp(0, _fullText.length)
            .floor();
        setState(() {
          _typedText = _fullText.substring(0, progress);
        });
      });
  }

  @override
  void dispose() {
    _typeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return VisibilityDetector(
      key: const Key('transparent_card_visibility'),
      onVisibilityChanged: (info) {
        if (!_hasPlayed && info.visibleFraction > 0.2) {
          _hasPlayed = true;
          _controller.forward();
          if (!_typingStarted) {
            _typingStarted = true;
            _typeController.repeat();
          }
        }
      },
      child: SlideTransition(
        position: isMobile ? _slideUp : _slideIn,
        child: FadeTransition(
          opacity: _fadeIn,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: isMobile ? 0 : 520),
            padding: isMobile
                ? const EdgeInsets.only(bottom: 24)
                : const EdgeInsets.all(AppSpacing.lg),
            decoration: isMobile
                ? null
                : BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14),
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TransparentCard()._chip(context),
                    const SizedBox(height: AppSpacing.lg),
                    _buildTypingTitle(isMobile),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppLocalizations.of(context)!
                          .transparentRealPerformanceDesc,
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 18 : 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _TransparentCard()
                        ._pill(AppLocalizations.of(context)!.results, isMobile),
                    _TransparentCard()._pill(
                        AppLocalizations.of(context)!.performanceTracking,
                        isMobile),
                    _TransparentCard()._pill(
                        AppLocalizations.of(context)!.accurate, isMobile),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingTitle(bool isMobile) {
    final showCursor = (_typeController.value % 0.6) > 0.3;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: _typedText),
          TextSpan(text: showCursor ? ' |' : '  '),
        ],
      ),
      style: AppTextStyles.h1.copyWith(
          fontSize: isMobile ? 23.6 : 29, fontWeight: FontWeight.w800),
      softWrap: true,
    );
  }
}

class _KeyFindingsCard extends StatefulWidget {
  const _KeyFindingsCard();

  @override
  State<_KeyFindingsCard> createState() => _KeyFindingsCardState();
}

class _KeyFindingsCardState extends State<_KeyFindingsCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
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
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < Breakpoints.tablet;
        final t = _controller.value;
        final colors = const [
          Color(0xFF04B3E9),
          Color(0xFF2E60FF),
          Color(0xFFD500F9)
        ];
        final stops = [
          (t + 0.0) % 1,
          (t + 0.4) % 1,
          (t + 0.8) % 1,
        ]..sort();

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: isMobile ? 400 : 520),
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
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Key Findings',
                    style: AppTextStyles.h3
                        .copyWith(fontSize: 22, color: Colors.white)),
                const SizedBox(height: AppSpacing.md),
                _chartPlaceholder(_controller.value),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Metric(
                        label: AppLocalizations.of(context)!.predictiveAccuracy,
                        value: '+81%'),
                    _Metric(
                        label: AppLocalizations.of(context)!
                            .improvementInProfitability,
                        value: '+37%'),
                    _Metric(
                        label: AppLocalizations.of(context)!
                            .improvedRiskManagement,
                        value: '+63%'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _chartPlaceholder(double progress) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [Color(0xFF111111), Color(0xFF0A0A0A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomPaint(
          painter: _ChartPainter(progress: progress),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final double progress;
  _ChartPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = const Color(0xFF00C6FF)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 1; i < 5; i++) {
      final dx = size.width * i / 5;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), gridPaint);
    }
    for (int i = 1; i < 4; i++) {
      final dy = size.height * i / 4;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), gridPaint);
    }

    final basePoints = [
      Offset(0, size.height * 0.55),
      Offset(size.width * 0.15, size.height * 0.6),
      Offset(size.width * 0.25, size.height * 0.45),
      Offset(size.width * 0.35, size.height * 0.7),
      Offset(size.width * 0.42, size.height * 0.9),
      Offset(size.width * 0.48, size.height * 0.35),
      Offset(size.width * 0.55, size.height * 0.15),
      Offset(size.width * 0.63, size.height * 0.6),
      Offset(size.width * 0.7, size.height * 0.8),
      Offset(size.width * 0.78, size.height * 0.5),
      Offset(size.width * 0.9, size.height * 0.25),
    ];

    final wiggle = 0.0;
    final points = <Offset>[];
    for (int i = 0; i < basePoints.length; i++) {
      // giữ nguyên hình dạng, chỉ dùng progress để vẽ dần
      points.add(basePoints[i]);
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // Vẽ dần từ trái sang phải theo progress
    final metrics = path.computeMetrics().toList();
    if (metrics.isNotEmpty) {
      final metric = metrics.first;
      final len = metric.length;
      final currentLen = (len * progress).clamp(0.0, len);
      if (currentLen > 0) {
        final animatedPath = metric.extractPath(0, currentLen);
        canvas.drawPath(animatedPath, linePaint);
        final tangent = metric.getTangentForOffset(currentLen);
        if (tangent != null) {
          canvas.drawCircle(
            tangent.position,
            4,
            Paint()
              ..color = const Color(0xFF00C6FF)
              ..style = PaintingStyle.fill,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class PerformanceSection extends StatelessWidget {
  const PerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 520),
              child: const _SignalsPerformanceCard(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 520),
              child: const _TransparentCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalsPerformanceCard extends StatefulWidget {
  const _SignalsPerformanceCard();

  @override
  State<_SignalsPerformanceCard> createState() =>
      _SignalsPerformanceCardState();
}

class _SignalsPerformanceCardState extends State<_SignalsPerformanceCard>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _itemsController;
  late final Animation<Offset> _slideIn;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _slideIn = Tween(begin: const Offset(-0.16, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );
    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _entranceController, curve: Curves.easeOut));
    _itemsController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return VisibilityDetector(
      key: const Key('signals_performance_visibility'),
      onVisibilityChanged: (info) {
        if (!_hasPlayed && info.visibleFraction > 0.2) {
          _hasPlayed = true;
          _entranceController.forward();
          _itemsController.repeat();
        }
      },
      child: SlideTransition(
        position: isMobile ? _slideUp : _slideIn,
        child: FadeTransition(
          opacity: _fadeIn,
          child: _AnimatedBorderCard(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: isMobile ? 280 : 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: isMobile ? 12 : 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0D101A), Color(0xFF0A0B13)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                        AppLocalizations.of(context)!.signalsPerformanceTitle,
                        style: AppTextStyles.h3.copyWith(
                            color: Colors.white, fontSize: isMobile ? 18 : 22)),
                  ),
                  _staggerItem(
                      0,
                      Icons.balance,
                      AppLocalizations.of(context)!.riskToRewardRatio,
                      AppLocalizations.of(context)!.howRiskComparesToReward),
                  _staggerItem(
                      1,
                      Icons.attach_money,
                      AppLocalizations.of(context)!.profitLossOverview,
                      AppLocalizations.of(context)!.netGainVsLoss),
                  _staggerItem(
                      2,
                      Icons.emoji_events,
                      AppLocalizations.of(context)!.winRate,
                      AppLocalizations.of(context)!.percentageOfWinningTrades),
                  _staggerItem(
                      3,
                      Icons.track_changes,
                      AppLocalizations.of(context)!.accuracyRate,
                      AppLocalizations.of(context)!.howPreciseOurSignalsAre),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _staggerItem(int index, IconData icon, String title, String subtitle) {
    return AnimatedBuilder(
      animation: _itemsController,
      builder: (context, child) {
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < Breakpoints.tablet;
        final phase = (_itemsController.value + index * 0.22) % 1.0;
        double opacity;
        if (phase < 0.2) {
          opacity = Curves.easeIn.transform(phase / 0.2);
        } else if (phase > 0.8) {
          opacity = Curves.easeOut.transform((1 - phase) / 0.2);
        } else {
          opacity = 1.0;
        }
        final slideT = Curves.easeInOut.transform(phase);
        final travel = 14.0;
        final baseOffset = 4.0;
        final offsetY = (lerpDouble(travel, -travel, slideT) ?? 0) + baseOffset;

        return FadeTransition(
          opacity: AlwaysStoppedAnimation(opacity),
          child: Transform.translate(offset: Offset(0, offsetY), child: child),
        );
      },
      child: LayoutBuilder(builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < Breakpoints.tablet;
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 8),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 12 : 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0xFF0D101A), Color(0xFF0A0B13)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.white70, size: isMobile ? 20 : 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppTextStyles.h3.copyWith(
                              fontSize: isMobile ? 16 : 22,
                              color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(subtitle,
                          style: AppTextStyles.caption.copyWith(
                              color: Colors.white70,
                              fontSize: isMobile ? 10 : 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _SignalsPerformanceRow extends StatelessWidget {
  const _SignalsPerformanceRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 520, maxWidth: 560),
              child: const SizedBox(
                width: double.infinity,
                child: _SignalsPerformanceCard(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 5,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 520, maxWidth: 560),
              child: const SizedBox(
                width: double.infinity,
                child: _TransparentCardAnimated(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TransparentCard extends StatelessWidget {
  const _TransparentCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: const _TransparentCardAnimated(),
    );
  }

  Widget _chip(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/ai-signals'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF04B3E9),
                  Color(0xFF2E60FF),
                  Color(0xFFD500F9)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.aiSignal,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, bool isMobile) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 1 : 6),
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class CoreValueSection extends StatelessWidget {
  const CoreValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    final items = [
      (
        title: AppLocalizations.of(context)!.realtimeMarketAnalysis,
        desc: AppLocalizations.of(context)!.realtimeMarketAnalysisDesc,
      ),
      (
        title: AppLocalizations.of(context)!.saveTimeOnAnalysis,
        desc: AppLocalizations.of(context)!.saveTimeOnAnalysisDesc,
      ),
      (
        title: AppLocalizations.of(context)!.minimizeEmotionalTrading,
        desc: AppLocalizations.of(context)!.minimizeEmotionalTradingDesc,
      ),
      (
        title: AppLocalizations.of(context)!.seizeEveryOpportunity,
        desc: AppLocalizations.of(context)!.seizeEveryOpportunityDesc,
      ),
    ];

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 0 : 32, vertical: 32),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.minvestAiCoreValueTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.h1.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 32 : 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppLocalizations.of(context)!.minvestAiCoreValueDesc,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 18 : 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < items.length; i++)
                _AnimatedCoreValueCard(
                  title: items[i].title,
                  description: items[i].desc,
                  slideFromLeft: i.isEven,
                ),
            ],
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Container(
      width: isMobile ? double.infinity : 550.0,
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 200),
      padding: EdgeInsets.all(isMobile ? 20 : AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: AppTextStyles.h3.copyWith(
              fontSize: isMobile ? 20 : 22,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            textAlign: TextAlign.start,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCoreValueCard extends StatefulWidget {
  final String title;
  final String description;
  final bool slideFromLeft;

  const _AnimatedCoreValueCard({
    required this.title,
    required this.description,
    required this.slideFromLeft,
  });

  @override
  State<_AnimatedCoreValueCard> createState() => _AnimatedCoreValueCardState();
}

class _AnimatedCoreValueCardState extends State<_AnimatedCoreValueCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _fade;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    final beginOffset =
        widget.slideFromLeft ? const Offset(-0.16, 0) : const Offset(0.16, 0);
    _slide = Tween(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return VisibilityDetector(
      key: Key('core_value_${widget.title}'),
      onVisibilityChanged: (info) {
        if (!_hasPlayed && info.visibleFraction > 0.15) {
          _hasPlayed = true;
          _controller.forward();
        }
      },
      child: SlideTransition(
        position: isMobile ? _slideUp : _slide,
        child: FadeTransition(
          opacity: _fade,
          child: _AnimatedBorderCard(
            child: _CoreValueCard(
              title: widget.title,
              description: widget.description,
            ),
          ),
        ),
      ),
    );
  }
}

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    final List<Map<String, String>> faqItems = [
      {
        'question': AppLocalizations.of(context)!.faqQuestion1,
        'answer': AppLocalizations.of(context)!.faqAnswer1,
      },
      {
        'question': AppLocalizations.of(context)!.faqQuestion2,
        'answer': AppLocalizations.of(context)!.faqAnswer2,
      },
      {
        'question': AppLocalizations.of(context)!.faqQuestion3,
        'answer': AppLocalizations.of(context)!.faqAnswer3,
      },
      {
        'question': AppLocalizations.of(context)!.faqQuestion4,
        'answer': AppLocalizations.of(context)!.faqAnswer4,
      },
    ];
    return _RevealOnScroll(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 0 : 24, vertical: 32),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.frequentlyAskedQuestions,
              style: AppTextStyles.h1.copyWith(
                fontSize: isMobile ? 32 : 32, // Keep as is or adjust if needed
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                AppLocalizations.of(context)!.faqSubtitle,
                style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 18 : 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ...faqItems.map((item) =>
                _FaqItem(question: item['question']!, answer: item['answer']!)),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(question,
            style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer.isEmpty ? 'Content updating...' : answer,
              style: AppTextStyles.caption
                  .copyWith(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return _RevealOnScroll(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 0 : 32, vertical: 32),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(isMobile ? 0 : 16),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.maximizeResultsTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(
                  fontSize: isMobile ? 32 : 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Text(
                  AppLocalizations.of(context)!.minvestAiRegistrationDesc,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 16,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Center(
                child: GradientButton(
                  label: AppLocalizations.of(context)!.startNow,
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  borderRadius: isMobile ? 1 : 6,
                  textStyle: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 18 : 14,
                  ),
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.of(context).pushNamed('/ai-signals');
                    } else {
                      Navigator.of(context).pushNamed('/signup');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RevealOnScroll extends StatefulWidget {
  final Widget child;
  const _RevealOnScroll({required this.child});

  @override
  State<_RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<_RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideUp;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _slideUp = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
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
      key: Key('reveal_${widget.hashCode}'),
      onVisibilityChanged: (info) {
        if (!_hasPlayed && info.visibleFraction > 0.15) {
          _hasPlayed = true;
          _controller.forward();
        }
      },
      child: SlideTransition(
        position: _slideUp,
        child: FadeTransition(
          opacity: _fadeIn,
          child: widget.child,
        ),
      ),
    );
  }
}
