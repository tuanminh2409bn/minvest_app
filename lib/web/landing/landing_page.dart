import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minvest_forex_app/features/auth/bloc/auth_bloc.dart';
import 'package:minvest_forex_app/features/auth/services/auth_service.dart';
import '../theme/colors.dart';
import '../theme/breakpoints.dart';
import '../theme/text_styles.dart';
import '../theme/spacing.dart';
import '../theme/content.dart';
import 'widgets/navbar.dart';
import 'widgets/gradient_button.dart';
import 'sections/pricing_section.dart';
import 'sections/footer_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth < Breakpoints.desktop && constraints.maxWidth >= Breakpoints.tablet;
          final isMobile = constraints.maxWidth < Breakpoints.tablet;
          final horizontalPadding = isMobile ? 16.0 : isTablet ? 24.0 : 32.0;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      SizedBox(height: 12),
                      LandingNavBar(),
                      HeroSection(),
                      HeroSubtitleSection(),
                      SizedBox(height: 96),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: HeroSignalsSection()),
                          SizedBox(width: 16),
                          Expanded(child: LiveSignalsSection()),
                        ],
                      ),
                      SizedBox(height: 96),
                      OrderEngineSection(),
                      SizedBox(height: 96),
                      PerformanceSection(),
                      SizedBox(height: 96),
                      CoreValueSection(),
                      SizedBox(height: 96),
                      PricingSection(),
                      FaqSection(),
                      CtaSection(),
                      FooterSection(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: _HeroInteractive(),
      ),
    );
  }
}

class _HeroInteractive extends StatefulWidget {
  @override
  State<_HeroInteractive> createState() => _HeroInteractiveState();
}

class _HeroInteractiveState extends State<_HeroInteractive> with SingleTickerProviderStateMixin {
  Offset _pointer = Offset.zero;
  late final AnimationController _contentController;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _ctaSlide;
  late final Animation<double> _ctaFade;
  bool _contentPlayed = false;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _titleSlide = Tween(begin: const Offset(-0.12, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _contentController, curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic)),
    );
    _titleFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: const Interval(0.0, 0.55, curve: Curves.easeOut)),
    );
    _subtitleSlide = Tween(begin: const Offset(-0.08, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _contentController, curve: const Interval(0.15, 0.7, curve: Curves.easeOutCubic)),
    );
    _subtitleFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: const Interval(0.15, 0.7, curve: Curves.easeOut)),
    );
    _ctaSlide = Tween(begin: const Offset(0, 0.16), end: Offset.zero).animate(
      CurvedAnimation(parent: _contentController, curve: const Interval(0.35, 1.0, curve: Curves.easeOutCubic)),
    );
    _ctaFade = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: const Interval(0.35, 1.0, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = const Size(1200, 800);
    final viewportWidth = MediaQuery.of(context).size.width;
    final scaleFactor = viewportWidth < size.width ? viewportWidth / size.width : 1.0;
    return MouseRegion(
      onHover: (event) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final local = renderBox.globalToLocal(event.position);
          setState(() {
            _pointer = Offset(
              (local.dx / size.width - 0.5).clamp(-1, 1),
              (local.dy / size.height - 0.5).clamp(-1, 1),
            );
          });
        }
      },
      onExit: (_) => setState(() => _pointer = Offset.zero),
      child: Transform.scale(
        scale: scaleFactor,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildBlob(size),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlob(Size size) {
    final dx = _pointer.dx * 12;
    final dy = _pointer.dy * 12;
    final scale = 1 + (_pointer.distance * 0.05);
    final rotateX = _pointer.dy * -0.12;
    final rotateY = _pointer.dx * 0.12;
    final skewX = _pointer.dx * 0.06;
    final skewY = _pointer.dy * 0.06;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      transform: _addSkew(Matrix4.identity()
        ..translate(dx, dy)
        ..rotateX(rotateX)
        ..rotateY(rotateY)
        ..scale(scale, scale)
        ..setEntry(3, 2, 0.0008), skewX, skewY),
      child: Image.asset(
        'assets/mockups/hero.png',
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent() {
    return Positioned.fill(
      child: VisibilityDetector(
        key: const Key('hero_content'),
        onVisibilityChanged: (info) {
          if (!_contentPlayed && info.visibleFraction > 0.12) {
            _contentPlayed = true;
            _contentController.forward();
          }
        },
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideTransition(
                  position: _titleSlide,
                  child: FadeTransition(
                    opacity: _titleFade,
                    child: Text(
                      'Guiding Traders & Growing Portfolios',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h1.copyWith(fontSize: 44),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SlideTransition(
                  position: _subtitleSlide,
                  child: FadeTransition(
                    opacity: _subtitleFade,
                    child: Text(
                      'The Ultimate AI Engine – Designed by Expert Traders.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body.copyWith(fontSize: 16, color: Colors.white70),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                SlideTransition(
                  position: _ctaSlide,
                  child: FadeTransition(
                    opacity: _ctaFade,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GradientButton(
                          label: 'Get Signal Now',
                          width: 188,
                          height: 38,
                          borderRadius: 6,
                          padding: EdgeInsets.zero,
                          textStyle: AppTextStyles.body.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.1,
                          ),
                          onPressed: () => Navigator.of(context).pushNamed('/signup'),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        SizedBox(
                          width: 138,
                          height: 38,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => context.read<AuthBloc>().add(SignInAnonymouslyRequested()),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.black,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Free Trial',
                                  style: AppTextStyles.body.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
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
        ),
      ),
    );
  }

  Matrix4 _addSkew(Matrix4 matrix, double skewX, double skewY) {
    final skewMatrix = Matrix4(
      1, skewX, 0, 0,
      skewY, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    );
    return matrix..multiply(skewMatrix);
  }
}

class HeroSubtitleSection extends StatelessWidget {
  const HeroSubtitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
      child: Column(
        children: [
          Text(
            'Global AI Innovation for the Next Generation of Trading Intelligence',
            textAlign: TextAlign.center,
            style: AppTextStyles.h3.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Transforming traditional trading with cloud-powered AI signals — adaptive to real-time market news and trends for faster, more precise, and emotion-free performance.',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class HeroSignalsSection extends StatefulWidget {
  const HeroSignalsSection({super.key});

  @override
  State<HeroSignalsSection> createState() => _HeroSignalsSectionState();
}

class _HeroSignalsSectionState extends State<HeroSignalsSection> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<Offset> _slideIn;
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
              position: _slideIn,
              child: FadeTransition(
                opacity: _fadeIn,
                child: _AnimatedGlowCard(
                  width: maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(context),
                        const SizedBox(height: AppSpacing.md),
                        _buildTabs(context),
                        const SizedBox(height: AppSpacing.md),
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
        'AI Signals',
        style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
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

class _AnimatedGlowCardState extends State<_AnimatedGlowCard> with SingleTickerProviderStateMixin {
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
          width: widget.width,
          padding: const EdgeInsets.all(2),
          constraints: const BoxConstraints(minHeight: 480),
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
    final center = Offset(size.width * (0.3 + 0.4 * progress), size.height * (0.7 - 0.4 * progress));
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
  bool shouldRepaint(covariant _GlowPainter oldDelegate) => oldDelegate.progress != progress;
}

class _StaggeredSignalCards extends StatefulWidget {
  const _StaggeredSignalCards();

  @override
  State<_StaggeredSignalCards> createState() => _StaggeredSignalCardsState();
}

class _StaggeredSignalCardsState extends State<_StaggeredSignalCards> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double viewportHeight = 300;
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
              entry: '30',
              sl: '3310',
              tp1: '3330',
              tp2: '3350',
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
              entry: '30',
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
          ]..sort((a, b) => b.progress.compareTo(a.progress)); // progress lớn hơn vẽ sau → nằm trên

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
    final baseOffset = viewportHeight * 0.12; // đẩy điểm xuất phát xuống dưới một chút
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pair, style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white)),
                  Text(date, style: AppTextStyles.body.copyWith(color: Colors.white70, fontWeight: FontWeight.w600)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line('Entry: $entry'),
                  _line('SL : $sl'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line('TP1: $tp1'),
                  _line('TP2 : $tp2'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _line(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: AppTextStyles.h3.copyWith(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class LiveSignalsSection extends StatefulWidget {
  const LiveSignalsSection({super.key});

  @override
  State<LiveSignalsSection> createState() => _LiveSignalsSectionState();
}

class _LiveSignalsSectionState extends State<LiveSignalsSection> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideIn;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;
  late final AnimationController _typeController;
  String _typedText = '';
  static const String _fullText = 'LIVE – 24/7 AI Trading Signals';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _slideIn = Tween(begin: const Offset(0.18, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _typeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4500))
      ..addListener(() {
        final phase = _typeController.value;
        final typingPortion = phase <= 0.8 ? (phase / 0.8) : 1.0; // 0-0.8 gõ, 0.8-1.0 giữ ở cuối
        final progress = (typingPortion * _fullText.length).clamp(0, _fullText.length).floor();
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
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
      child: VisibilityDetector(
        key: const Key('live_signals_visibility'),
        onVisibilityChanged: (info) {
          if (!_hasPlayed && info.visibleFraction > 0.2) {
            _hasPlayed = true;
            _controller.forward();
          }
        },
        child: SlideTransition(
          position: _slideIn,
          child: FadeTransition(
            opacity: _fadeIn,
            child: Container(
              constraints: const BoxConstraints(minHeight: 480),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _chip(context, 'AI Signals'),
                  const SizedBox(height: AppSpacing.lg),
                  _buildTypingTitle(),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Real-time cloud analytics delivering high-probability, trend-following strategies with adaptive precision and emotion-free execution.',
                    style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _outlinedChip('AI Signals'),
                      _outlinedChip('Trend-Following'),
                      _outlinedChip('Real-time'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingTitle() {
    // Con trỏ nhấp nháy, bắt đầu ngay từ đầu chu kỳ.
    final showCursor = (_typeController.value % 0.6) < 0.3;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: _typedText),
          TextSpan(text: showCursor ? ' |' : '  '),
        ],
      ),
      style: AppTextStyles.h1.copyWith(fontSize: 42, fontWeight: FontWeight.w800),
      softWrap: true,
    );
  }

  Widget _chip(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/ai-signals'),
      child: Container(
        padding: const EdgeInsets.all(1.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.black,
          ),
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _outlinedChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.black,
      ),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}

class OrderEngineSection extends StatefulWidget {
  const OrderEngineSection({super.key});

  @override
  State<OrderEngineSection> createState() => _OrderEngineSectionState();
}

class _OrderEngineSectionState extends State<OrderEngineSection> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _leftSlide;
  late final Animation<Offset> _rightSlide;
  late final Animation<double> _leftFade;
  late final Animation<double> _rightFade;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _leftSlide = Tween(begin: const Offset(-0.18, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _rightSlide = Tween(begin: const Offset(0.18, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _leftFade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _rightFade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: VisibilityDetector(
        key: const Key('order_engine_visibility'),
        onVisibilityChanged: (info) {
          if (!_hasPlayed && info.visibleFraction > 0.2) {
            _hasPlayed = true;
            _controller.forward();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 520),
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
            const SizedBox(width: 16),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 520),
                child: SlideTransition(
                  position: _rightSlide,
                  child: FadeTransition(
                    opacity: _rightFade,
                    child: const _KeyFindingsCard(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
  String _typedText = '';
  static const String _fullText = 'Order Explanation Engine';

  @override
  void initState() {
    super.initState();
    _typeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4500))
      ..addListener(() {
        final phase = _typeController.value;
        final typingPortion = phase <= 0.8 ? (phase / 0.8) : 1.0; // 0-0.8 gõ, 0.8-1.0 giữ ở cuối
        final progress = (typingPortion * _fullText.length).clamp(0, _fullText.length).floor();
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
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _chip(context),
          const SizedBox(height: AppSpacing.lg),
          _buildTypingTitle(),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Explains trade setups in simple terms — showing how confluences form, why entries are made, and helping traders learn from each decision.',
            style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: [
              _pill('Transparent'),
              _pill('Educational'),
              _pill('Logical'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypingTitle() {
    final showCursor = (_typeController.value % 0.6) > 0.3; // blink chậm
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: _typedText),
          TextSpan(text: showCursor ? ' |' : '  '),
        ],
      ),
      style: AppTextStyles.h1.copyWith(fontSize: 40, fontWeight: FontWeight.w800),
      softWrap: true,
    );
  }

  Widget _chip(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/ai-signals'),
      child: Container(
        padding: const EdgeInsets.all(1.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.black,
          ),
          child: Text(
            'AI Signals',
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.black,
      ),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _TransparentCardAnimated extends StatefulWidget {
  const _TransparentCardAnimated();

  @override
  State<_TransparentCardAnimated> createState() => _TransparentCardAnimatedState();
}

class _TransparentCardAnimatedState extends State<_TransparentCardAnimated> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideIn;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;
  late final AnimationController _typeController;
  String _typedText = '';
  bool _typingStarted = false;
  static const String _fullText = 'Transparent - Real Performance';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _slideIn = Tween(begin: const Offset(0.16, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _typeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4500))
      ..addListener(() {
        final phase = _typeController.value;
        final typingPortion = phase <= 0.8 ? (phase / 0.8) : 1.0;
        final progress = (typingPortion * _fullText.length).clamp(0, _fullText.length).floor();
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
        position: _slideIn,
        child: FadeTransition(
          opacity: _fadeIn,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TransparentCard()._chip(context),
                const SizedBox(height: AppSpacing.lg),
                _buildTypingTitle(),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'See real data on signal accuracy, success rate, and profitability — verified and traceable in every trade',
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 17),
                ),
                const SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  children: [
                    _TransparentCard()._pill('Results'),
                    _TransparentCard()._pill('Performance-Tracking'),
                    _TransparentCard()._pill('Accurate'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypingTitle() {
    final showCursor = (_typeController.value % 0.6) > 0.3;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: _typedText),
          TextSpan(text: showCursor ? ' |' : '  '),
        ],
      ),
      style: AppTextStyles.h1.copyWith(fontSize: 40, fontWeight: FontWeight.w800),
      softWrap: true,
    );
  }
}

class _KeyFindingsCard extends StatefulWidget {
  const _KeyFindingsCard();

  @override
  State<_KeyFindingsCard> createState() => _KeyFindingsCardState();
}

class _KeyFindingsCardState extends State<_KeyFindingsCard> with SingleTickerProviderStateMixin {
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
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Key Findings', style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white)),
                const SizedBox(height: AppSpacing.md),
                _chartPlaceholder(_controller.value),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _Metric(label: 'Predictive Accuracy', value: '+81%'),
                    _Metric(label: 'Improvement in Profitability', value: '+37%'),
                    _Metric(label: 'Improved Risk Management', value: '+63%'),
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
      aspectRatio: 16 / 9,
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
            style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
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
  bool shouldRepaint(covariant _ChartPainter oldDelegate) => oldDelegate.progress != progress;
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
  State<_SignalsPerformanceCard> createState() => _SignalsPerformanceCardState();
}

class _SignalsPerformanceCardState extends State<_SignalsPerformanceCard> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _itemsController;
  late final Animation<Offset> _slideIn;
  late final Animation<double> _fadeIn;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _slideIn = Tween(begin: const Offset(-0.16, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
    );
    _fadeIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _entranceController, curve: Curves.easeOut));
    _itemsController = AnimationController(vsync: this, duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        position: _slideIn,
        child: FadeTransition(
          opacity: _fadeIn,
          child: _AnimatedBorderCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D101A), Color(0xFF0A0B13)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Text('Signals Performance', style: AppTextStyles.h3.copyWith(color: Colors.white)),
                ),
                _staggerItem(0, Icons.balance, 'Risk-to-Reward Ratio', 'How risk compares to reward'),
                _staggerItem(1, Icons.attach_money, 'Profit/Loss Overview', 'Net gain vs loss'),
                _staggerItem(2, Icons.emoji_events, 'Win Rate', 'Percentage of winning trades'),
                _staggerItem(3, Icons.track_changes, 'Accuracy Rate', 'How precise our signals are'),
              ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
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
              Icon(icon, color: Colors.white70, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.h3.copyWith(fontSize: 18, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
      child: Container(
        padding: const EdgeInsets.all(1.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.black,
          ),
          child: Text(
            'AI Signals',
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
        color: Colors.black,
      ),
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }
}

class CoreValueSection extends StatelessWidget {
  const CoreValueSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        title: 'Real-Time Market Analysis',
        desc:
            'Our AI monitors the market continuously, identifying technical convergence zones and reliable breakout points so you can enter trades at the right moment.'
      ),
      (
        title: 'Save Time on Analysis',
        desc:
            'No more hours spent reading charts. Receive tailored investment strategies in just minutes a day.'
      ),
      (
        title: 'Minimize Emotional Trading',
        desc:
            'With smart alerts, risk detection, and data-driven signals not emotions you stay disciplined and in control of every decision.'
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
    return Container(
      width: 520,
      constraints: const BoxConstraints(minHeight: 200),
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

class _AnimatedCoreValueCardState extends State<_AnimatedCoreValueCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    final beginOffset = widget.slideFromLeft ? const Offset(-0.16, 0) : const Offset(0.16, 0);
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
      key: Key('core_value_${widget.title}'),
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
    final items = LandingContent.faqItems;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          Text('Frequently Asked Questions', style: AppTextStyles.h1.copyWith(fontSize: 28)),
          const SizedBox(height: AppSpacing.md),
          ...items.map((item) => _FaqItem(question: item['question']!, answer: item['answer']!)),
        ],
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
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(question, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer.isEmpty ? 'Content updating...' : answer,
              style: AppTextStyles.caption.copyWith(color: Colors.white, fontSize: 14),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Column(
          children: [
            Text(
              'Maximize your results with Minvest AI advanced market analysis and precision-filtered signals',
              style: AppTextStyles.h3.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Elevate your trading with AI-enhanced strategies crafted for consistency and clarity.',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientButton(
                  label: 'Get Signals Now',
                  onPressed: () => Navigator.of(context).pushNamed('/signup'),
                ),
                const SizedBox(width: AppSpacing.md),
                TextButton(
                  onPressed: () => context.read<AuthBloc>().add(SignInAnonymouslyRequested()),
                  child: Text('Try demo', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
