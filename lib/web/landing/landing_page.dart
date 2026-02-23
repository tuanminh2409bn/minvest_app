import 'dart:math' as math;
import 'dart:async' as java_async;
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
import 'package:provider/provider.dart';
import 'package:minvest_forex_app/features/notifications/providers/notification_provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState.status == AuthStatus.authenticated) {
        context.read<NotificationProvider>().startListening();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.read<NotificationProvider>().startListening();
        } else if (state.status == AuthStatus.unauthenticated) {
          context.read<NotificationProvider>().stopListeningAndReset();
        }
      },
      child: Scaffold(
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
                      ? const TextScaler.linear(0.9)
                      : const TextScaler.linear(1.0),
                ),
                                child: Container(
                                  color: AppColors.background,
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverPadding(
                                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                        sliver: SliverToBoxAdapter(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 1200),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  const SizedBox(height: 12),
                                                  const RepaintBoundary(child: LandingNavBar()),
                                                  const RepaintBoundary(child: HeroSection()),
                                                  SizedBox(height: sectionSpacing),
                                                  const RepaintBoundary(child: HeroSubtitleSection()),
                                                  SizedBox(height: sectionSpacing),
                                                  RepaintBoundary(
                                                    child: LayoutBuilder(
                                                      builder: (context, constraints) {
                                                        final bool isNarrow = constraints.maxWidth < 900;
                                                        if (isNarrow) {
                                                          return const Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                              LiveSignalsSection(),
                                                              SizedBox(height: 24),
                                                              HeroSignalsSection(),
                                                            ],
                                                          );
                                                        }
                                                        return const Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(child: HeroSignalsSection()),
                                                            SizedBox(width: 16),
                                                            Expanded(child: LiveSignalsSection()),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SliverPadding(
                                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                                        sliver: SliverToBoxAdapter(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 1200),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: sectionSpacing),
                                                  RepaintBoundary(
                                                    child: LayoutBuilder(
                                                      builder: (context, constraints) {
                                                        final bool isNarrow = constraints.maxWidth < 900;
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
                                                        return const Column(
                                                          children: [
                                                            OrderEngineSection(),
                                                            SizedBox(height: 72),
                                                            _SignalsPerformanceRow(),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: sectionSpacing),
                                                  const RepaintBoundary(child: CoreValueSection()),
                                                  SizedBox(height: sectionSpacing),
                                                  const RepaintBoundary(child: PricingSection()),
                                                  SizedBox(height: sectionSpacing),
                                                  const RepaintBoundary(child: FaqSection()),
                                                  SizedBox(height: sectionSpacing),
                                                  const RepaintBoundary(child: CtaSection()),
                                                  SizedBox(height: sectionSpacing),
                                                  const RepaintBoundary(child: FooterSection()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(builder: (context, constraints) {
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
    }));
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
    
    // Desktop Horizontal Slides -> Changed to Vertical Up
    _titleSlide =
        Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _contentController,
          curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic)),
    );
    _subtitleSlide =
        Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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
          Positioned.fill(
            child: const RepaintBoundary(
              child: OrbEffect(),
            ),
          ),

          // Lớp bắt sự kiện chuột (Catcher)
          Positioned.fill(
            child: RepaintBoundary(
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
          )),

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
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1300), // Tăng width để chứa chữ to hơn trên 1 hàng ngang
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedWidget(
              slideAnim: isMobile ? _titleSlideUp : _titleSlide,
              fadeAnim: _titleFade,
              child: Text(
                AppLocalizations.of(context)!.heroTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.heroTitle.copyWith(
                  fontSize: isMobile ? 35 : 64, 
                  letterSpacing: isMobile ? -1.3 : -1.92,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildAnimatedWidget(
              slideAnim: isMobile ? _subtitleSlideUp : _subtitleSlide,
              fadeAnim: _subtitleFade,
              child: Text(
                AppLocalizations.of(context)!.heroSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.h2.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 18 : 36,
                  letterSpacing: isMobile ? -0.9 : -1.08,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildAnimatedWidget(
              slideAnim: _ctaSlide, 
              fadeAnim: _ctaFade,
              child: Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    GradientButton(
                      label: AppLocalizations.of(context)!.getSignalsNow,
                      width: isEnglish ? (isMobile ? 146 : 188) : null,
                      height: isMobile ? 32 : 38,
                      padding: isEnglish ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 12),
                      borderRadius: isMobile ? 2 : 6,
                      textStyle: AppTextStyles.bodyBold.copyWith(
                        fontSize: isMobile ? 12 : 18,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: isMobile ? -0.6 : -0.54,
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
                      borderRadius: BorderRadius.circular(isMobile ? 2 : 6),
                      onTap: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState.status == AuthStatus.authenticated) {
                          Navigator.of(context).pushNamed('/ai-signals');
                        } else {
                          Navigator.of(context).pushNamed('/signin');
                        }
                      },
                      child: Container(
                        width: isEnglish ? (isMobile ? 78 : 100) : null,
                        constraints: isEnglish ? null : BoxConstraints(minWidth: isMobile ? 78 : 100),
                        height: isMobile ? 32 : 38,
                        padding: const EdgeInsets.all(1), 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isMobile ? 2 : 6),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(isMobile ? 1 : 5),
                            color: Colors.black,
                          ),
                          padding: isEnglish ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.freeTrial,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyBold.copyWith(
                                  color: Colors.white,
                                  fontSize: isMobile ? 12 : 18,
                                  height: 1.1,
                                  letterSpacing: isMobile ? -0.6 : -0.54,
                                ),
                              ),
                            ],
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

    return RepaintBoundary(
      child: _RevealOnScroll(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.globalAiInnovationTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.h2.copyWith(
                fontSize: isMobile ? 22 : 36,
                letterSpacing: isMobile ? -0.5 : -1.08,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppLocalizations.of(context)!.globalAiInnovationDesc,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white,
                fontSize: isMobile ? 18 : 22,
                letterSpacing: isMobile ? -0.4 : -0.66,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ));
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

  // State cho dots indicator
  int _currentCardIndex = 0;
  final int _totalCards = 3;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _slideIn = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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

    return RepaintBoundary(
      child: LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = isMobile 
            ? double.infinity // Cho phép chiếm toàn bộ chiều rộng có sẵn trên mobile
            : constraints.maxWidth.clamp(320.0, 500.0);
            
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
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none, 
                  children: [
                    // Nền xám mờ bao quanh (Chỉ hiện trên desktop)
                    if (!isMobile)
                      Positioned(
                        top: -30,
                        left: -30,
                        right: -30,
                        bottom: -30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                    // Nội dung chính
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : maxWidth),
                      child: _AnimatedBorderCard(
                        child: Container(
                          constraints: BoxConstraints(minHeight: isMobile ? 0 : 540), // Reverted to 540
                          padding: EdgeInsets.all(isMobile ? 16 : AppSpacing.md),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start, // Changed from spaceBetween to start
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSearchBar(context),
                                  const SizedBox(height: AppSpacing.md),
                                  _buildTabs(context),
                                ],
                              ),
                              const SizedBox(height: 16), // Giảm từ 32 xuống 16
                              if (isMobile) const SizedBox(height: 24),
                              _CarouselSignalCards(
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentCardIndex = index % 3;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Overlay mờ đen (Đè lên cả viền và nền xám)
                    Positioned(
                      left: -31,
                      right: -31,
                      bottom: -31, // Tràn xuống đáy của nền xám
                      height: 180, // Increased from 60
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.9),
                                Colors.black, // Đen hoàn toàn
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                            // Bo góc dưới khớp với nền xám
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),

                    // Thanh tiến trình (Dots + Connecting Lines)
                    Positioned(
                      bottom: -10, // Đặt thấp hơn một chút
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDot(isActive: true), // Chấm đầu luôn sáng
                          _buildConnectingLine(isFilled: _currentCardIndex >= 1, delayOff: const Duration(milliseconds: 500)),
                          _buildDot(isActive: _currentCardIndex >= 1),
                          _buildConnectingLine(isFilled: _currentCardIndex >= 2),
                          _buildDot(isActive: _currentCardIndex >= 2),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        AppLocalizations.of(context)!.aiSignal,
        style: AppTextStyles.body.copyWith(
          color: const Color(0xFF9A9A9A),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    Widget tab(String text, {bool active = false}) {
      return InkWell(
        child: Container(
          width: 72.71,
          height: 31,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF141414),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: const Color(0xFF9A9A9A),
              fontWeight: FontWeight.w600,
              fontSize: 18,
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

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF444444),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildConnectingLine({required bool isFilled, Duration delayOff = Duration.zero}) {
    return _ConnectingLine(isFilled: isFilled, delayOff: delayOff);
  }
}

class _ConnectingLine extends StatefulWidget {
  final bool isFilled;
  final Duration delayOff;

  const _ConnectingLine({required this.isFilled, this.delayOff = Duration.zero});

  @override
  State<_ConnectingLine> createState() => _ConnectingLineState();
}

class _ConnectingLineState extends State<_ConnectingLine> {
  bool _localIsFilled = false;

  @override
  void initState() {
    super.initState();
    _localIsFilled = widget.isFilled;
  }

  @override
  void didUpdateWidget(covariant _ConnectingLine oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFilled != oldWidget.isFilled) {
      if (widget.isFilled) {
        // Turn ON: Immediate
        setState(() => _localIsFilled = true);
      } else {
        // Turn OFF: Delay if needed
        if (widget.delayOff != Duration.zero) {
           java_async.Future.delayed(widget.delayOff, () {
             if (mounted && !widget.isFilled) {
               setState(() => _localIsFilled = false);
             }
           });
        } else {
           setState(() => _localIsFilled = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // 150px theo yêu cầu
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(1),
      ),
      child: Stack(
        children: [
          AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            widthFactor: _localIsFilled ? 1.0 : 0.0,
            alignment: Alignment.centerLeft, // Rút về bên trái (về điểm 1)
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _AnimatedBorderCard extends StatelessWidget {
  final Widget child;
  const _AnimatedBorderCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xFF04B3E9),
      Color(0xFF2E60FF),
      Color(0xFFD500F9)
    ];

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}

class _CarouselSignalCards extends StatefulWidget {
  final ValueChanged<int>? onPageChanged;
  const _CarouselSignalCards({this.onPageChanged});

  @override
  State<_CarouselSignalCards> createState() => _CarouselSignalCardsState();
}

class _CarouselSignalCardsState extends State<_CarouselSignalCards> {
  late final PageController _pageController;
  int _currentPage = 0;
  java_async.Timer? _timer;
  bool _isVisible = false;

  // Define 3 cards
  final List<Widget> _cards = const [
// ... (giữ nguyên danh sách cards)
    _SignalCard(
      icon: Icons.auto_awesome,
      iconColor: Color(0xFFFFA000),
      pair: 'XAU/USD',
      date: 'June 1, 2025',
      entry: '3020',
      sl: '3310',
      tp1: '3330',
      tp2: '3350',
      badgeLabel: 'Buy Limit',
      badgeGradient: LinearGradient(
        colors: [Color(0xFF2E60FF), Color(0xFF2E60FF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    _SignalCard(
      icon: Icons.currency_bitcoin,
      iconColor: Color(0xFF00B6FF),
      pair: 'BTC/USD',
      date: 'June 1, 2025',
      entry: '93.000',
      sl: '93.300',
      tp1: '92.700',
      tp2: '92.500',
      badgeLabel: 'Sell Limit',
      badgeGradient: LinearGradient(
        colors: [Color(0xFFD500F9), Color(0xFFD500F9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    _SignalCard(
      icon: Icons.token,
      iconColor: Color(0xFF627EEA),
      pair: 'ETH/USD',
      date: 'June 1, 2025',
      entry: '4.200',
      sl: '4.100',
      tp1: '4.350',
      tp2: '4.500',
      badgeLabel: 'Buy Limit',
      badgeGradient: LinearGradient(
        colors: [Color(0xFF2E60FF), Color(0xFF2E60FF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    _SignalCard(
      icon: Icons.currency_yen,
      iconColor: Color(0xFFFF5252),
      pair: 'USD/JPY',
      date: 'June 2, 2025',
      entry: '155.40',
      sl: '156.00',
      tp1: '154.50',
      tp2: '154.00',
      badgeLabel: 'Sell Limit',
      badgeGradient: LinearGradient(
        colors: [Color(0xFFD500F9), Color(0xFFD500F9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    _SignalCard(
      icon: Icons.currency_pound,
      iconColor: Color(0xFF00BFA5),
      pair: 'GBP/USD',
      date: 'June 2, 2025',
      entry: '1.2650',
      sl: '1.2600',
      tp1: '1.2720',
      tp2: '1.2780',
      badgeLabel: 'Buy Limit',
      badgeGradient: LinearGradient(
        colors: [Color(0xFF2E60FF), Color(0xFF2E60FF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1000 * _cards.length, viewportFraction: 0.35);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = java_async.Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && _isVisible) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('carousel_signals_visibility'),
      onVisibilityChanged: (info) {
        final visible = info.visibleFraction > 0.1;
        if (visible != _isVisible) {
          _isVisible = visible;
          if (_isVisible) {
            _startTimer();
          } else {
            _stopTimer();
          }
        }
      },
      child: SizedBox(
        height: 400, 
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            if (widget.onPageChanged != null) {
              widget.onPageChanged!(index % _cards.length);
            }
          },
          itemBuilder: (context, index) {
            final cardIndex = index % _cards.length;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RepaintBoundary(child: _cards[cardIndex]),
            );
          },
        ),
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
        final double pairFontSize = isNarrow ? 16.0 : 18.0;
        final double dateFontSize = isNarrow ? 14.0 : 16.0;
        final double badgeFontSize = isNarrow ? 16.0 : 18.0;
        final double lineFontSize = isNarrow ? 16.0 : 18.0;

        return Container(
          width: double.infinity,
          height: null, // Để thẻ tự co theo nội dung, loại bỏ khoảng thừa dưới
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), // Giảm padding dọc xuống 12 để tránh overflow
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white, width: 0.40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Đảm bảo cột chỉ chiếm không gian vừa đủ
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 48.53,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(pair,
                            style: AppTextStyles.bodyBold.copyWith(
                                fontSize: pairFontSize,
                                color: Colors.white,
                                letterSpacing: -0.54,
                                height: 1.1,
                            )),
                        Text(date,
                            style: AppTextStyles.caption.copyWith(
                                fontSize: dateFontSize,
                                color: const Color(0xFF9A9A9A),
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.48,
                                height: 1.1,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: 108,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: badgeGradient,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      badgeLabel,
                      style: AppTextStyles.bodyBold.copyWith(
                        fontSize: badgeFontSize,
                        color: Colors.white,
                        letterSpacing: -0.54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(child: _line('Entry: $entry', lineFontSize)),
                      Expanded(child: _line('TP1: $tp1', lineFontSize)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _line('SL : $sl', lineFontSize)),
                      Expanded(child: _line('TP2 : $tp2', lineFontSize)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _line(String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4), // Trả lại padding chữ như cũ
      child: Text(
        text,
        style: AppTextStyles.body.copyWith( // 18px, w400
            fontSize: fontSize,
            color: Colors.white,
            letterSpacing: -0.54,
            height: 1.2,
        ),
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
    _slideIn = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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

    return RepaintBoundary(
      child: Padding(
      padding: EdgeInsets.only(top: isMobile ? 0 : 140),
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
    ));
  }

  Widget _buildContent(bool isMobile) {
    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 350),
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
          _chip(context, AppLocalizations.of(context)!.aiSignal, isMobile),
          const SizedBox(height: AppSpacing.lg),
          _buildTypingTitle(isMobile),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity, // Allow full width expansion
            child: Text(
              AppLocalizations.of(context)!.liveTradingSignalsDesc,
              // Figma: 18px, w400, -0.9 spacing
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w400, // Explicitly w400
                letterSpacing: -0.54,
                height: 1.1, // Adjust line height if needed
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _outlinedChip(AppLocalizations.of(context)!.aiSignal, isMobile),
                const SizedBox(width: 8),
                _outlinedChip(AppLocalizations.of(context)!.trendFollowing, isMobile),
                const SizedBox(width: 8),
                _outlinedChip(AppLocalizations.of(context)!.realtime, isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingTitle(bool isMobile) {
    // Con trỏ nhấp nháy, bắt đầu ngay từ đầu chu kỳ.
    final showCursor = (_typeController.value % 0.6) < 0.3;
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: _typedText),
            TextSpan(text: showCursor ? ' |' : '  '),
          ],
        ),
        maxLines: 1,
        // Figma: 36px, w700, -1.8 spacing
        style: AppTextStyles.h2.copyWith(
            color: Colors.white,
            fontSize: isMobile ? 20.0 : 36, 
            fontWeight: FontWeight.w700, // Figma: w700
            letterSpacing: isMobile ? -0.78 : -1.08, // Figma: -1.08
            height: 1.2,
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String text, bool isMobile) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/ai-signals'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: isMobile ? 28 : 35, // Figma: Fixed height 35
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 2 : 6), // Figma: Radius 6
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
            padding: const EdgeInsets.all(1.0),
            child: Container(
              // Figma: Inner content
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 14), 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 1.5 : 5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: AppTextStyles.bodyBold.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 14 : 18, // Figma: 18
                  fontWeight: FontWeight.w600, // Figma: w600
                  letterSpacing: isMobile ? -0.5 : -0.54, // Figma: -0.90
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _outlinedChip(String text, bool isMobile, {double? width}) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Container(
      width: isMobile ? null : ((isEnglish) ? width : null), 
      height: isMobile ? 28 : 35, 
      padding: isMobile 
          ? const EdgeInsets.symmetric(horizontal: 16)
          : ((!isEnglish) ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 2 : 6), 
        border: Border.all(color: Colors.white, width: isMobile ? 0.8 : 1),
        color: Colors.transparent, 
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodyBold.copyWith(
          color: Colors.white,
          fontSize: isMobile ? 14 : 18, 
          fontWeight: FontWeight.w600, 
          letterSpacing: isMobile ? -0.5 : -0.54,
          height: 1.1,
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
    _leftSlide = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _rightSlide = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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
    return RepaintBoundary(
      child: LayoutBuilder(
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minHeight: 400, maxWidth: 600), // Increased to 600
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Center(
                                                      child: ConstrainedBox(
                                                        constraints: const BoxConstraints(
                                                            minHeight: 520, maxWidth: 800), // Increased from 700 to 800
                                                        child: SizedBox(                              width: double.infinity,
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
    ));
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
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 400),
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
            // Figma: 18px, w400, -1.44 spacing
            style: AppTextStyles.body.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w400, // Figma: w400
              letterSpacing: isMobile ? -0.48 : -0.86, // Figma: -1.44
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _pill(context, AppLocalizations.of(context)!.transparent, isMobile),
                const SizedBox(width: 8),
                _pill(context, AppLocalizations.of(context)!.educational, isMobile),
                const SizedBox(width: 8),
                _pill(context, AppLocalizations.of(context)!.logical, isMobile),
              ],
            ),
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
      // Figma: 36px, w700, -1.8 spacing
      style: AppTextStyles.h2.copyWith(
          color: Colors.white,
          fontSize: isMobile ? 20.0 : 36, 
          fontWeight: FontWeight.w700, // Figma: w700
          letterSpacing: isMobile ? -0.78 : -1.08, // Figma: -1.80
          height: 1.2,
      ),
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
            height: 28, // Match Live Signals
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
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
            padding: const EdgeInsets.all(1.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.aiSignal,
                style: AppTextStyles.bodyBold.copyWith(
                  color: Colors.white,
                  fontSize: 14, // Match Live Signals
                  fontWeight: FontWeight.w600, // Figma: w600
                  letterSpacing: -0.54, // Figma: -0.90
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(BuildContext context, String text, bool isMobile, {double? width}) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Container(
      width: isMobile ? null : ((isEnglish && !isMobile) ? width : null), 
      height: isMobile ? 28 : 35, 
      padding: isMobile 
          ? const EdgeInsets.symmetric(horizontal: 16)
          : ((!isMobile && !isEnglish) ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 2 : 6),
        border: Border.all(color: Colors.white, width: isMobile ? 0.8 : 1),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTextStyles.bodyBold.copyWith(
          color: Colors.white,
          fontSize: isMobile ? 14 : 18, 
          fontWeight: FontWeight.w600, 
          letterSpacing: -0.54, 
          height: 1.1,
        ),
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
    _slideIn = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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

    return RepaintBoundary(
      child: VisibilityDetector(
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
                      // Figma: 18px, w400, -0.9 spacing
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w400, // Figma: w400
                        letterSpacing: isMobile ? -0.33 : -0.54, // Figma: -0.90
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _TransparentCard()._pill(context, AppLocalizations.of(context)!.results, isMobile),
                      const SizedBox(width: 8),
                      _TransparentCard()._pill(context, AppLocalizations.of(context)!.performanceTracking, isMobile),
                      const SizedBox(width: 8),
                      _TransparentCard()._pill(context, AppLocalizations.of(context)!.accurate, isMobile),
                    ],
                  ),
                ),              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildTypingTitle(bool isMobile) {
    final showCursor = (_typeController.value % 0.6) > 0.3;
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: _typedText),
            TextSpan(text: showCursor ? ' |' : '  '),
          ],
        ),
        maxLines: 1,
        // Figma: 36px, w700, -1.8 spacing
        style: AppTextStyles.h2.copyWith(
            color: Colors.white,
            fontSize: isMobile ? 20.0 : 36, // Match LiveSignals
            fontWeight: FontWeight.w700,
            letterSpacing: isMobile ? -0.78 : -1.08,
            height: 1.2, // Match LiveSignals
        ),
      ),
    );
  }
}

class _KeyFindingsCard extends StatelessWidget {
  const _KeyFindingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Nền xám mở rộng (Chỉ hiện trên desktop)
        if (!isMobile)
          Positioned(
            top: -30,
            left: -30,
            right: -30,
            bottom: -30,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

        // 2. Nội dung chính
        _AnimatedBorderCard(
          child: Container(
            constraints: BoxConstraints(minHeight: isMobile ? 0 : 520),
            padding: EdgeInsets.all(isMobile ? 12 : AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.keyFindings,
                    // Figma: 20px, w600, -1.0 spacing
                    style: AppTextStyles.h3.copyWith(
                        fontSize: isMobile ? 18 : 20, 
                        color: const Color(0xFF9A9A9A), // Màu xám nhạt theo thiết kế
                        letterSpacing: -0.6,
                    )),
                SizedBox(height: isMobile ? 12 : AppSpacing.md),
                // Trả về một widget StatefulWidget nhỏ chỉ để chạy animation biểu đồ
                _AnimatedChartContent(),
                SizedBox(height: isMobile ? 12 : AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Metric(
                        label: AppLocalizations.of(context)!.predictiveAccuracy,
                        value: '+81%',
                        flex: 3), // Increased flex
                    _Metric(
                        label: AppLocalizations.of(context)!
                            .improvementInProfitability,
                        value: '+37%',
                        flex: 4), // Kept flex
                    _Metric(
                        label: AppLocalizations.of(context)!
                            .improvedRiskManagement,
                        value: '+63%',
                        flex: 4), // Increased flex
                  ],
                ),
                const SizedBox(height: 40), // Thêm khoảng trống ở đáy để đẩy chữ lên cao
              ],
            ),
          ),
        ),

        // 3. Lớp phủ đen mờ mở rộng ở đáy
        Positioned(
          left: -31,
          right: -31,
          bottom: -31,
          height: 120, // Giảm từ 180 xuống 120 để bớt che nội dung
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.9),
                    Colors.black,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Helper widget for metrics to keep code clean and apply styles consistently
class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final int flex;

  const _Metric({required this.label, required this.value, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 500; // Small breakpoint for metrics

    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Figma: Centered layout
        children: [
          Text(
            value,
            // Figma: 18px, w600, -0.9 spacing, White
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.54,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8), // Tăng khoảng cách một chút theo Figma (top 36 - 18 = 18? thực tế khoảng 8-12 là đẹp)
          Text(
            label,
            textAlign: TextAlign.center, // Đảm bảo text label cũng căn giữa
            // Figma: 14px, w400, -0.7 spacing, #A3A3A3
            style: AppTextStyles.caption.copyWith(
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFA3A3A3),
              letterSpacing: -0.42,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// Tách phần animation biểu đồ ra riêng để giữ hiệu ứng vẽ dần
class _AnimatedChartContent extends StatefulWidget {
  @override
  State<_AnimatedChartContent> createState() => _AnimatedChartContentState();
}

class _AnimatedChartContentState extends State<_AnimatedChartContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(); // Lặp lại để tạo hiệu ứng vẽ liên tục
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
      builder: (context, _) => _chartPlaceholder(_controller.value),
    );
  }

  Widget _chartPlaceholder(double progress) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Nền đen tuyệt đối
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomPaint(
          painter: _ChartPainter(progress: progress),
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final double progress;
  _ChartPainter({required this.progress});

  // Caching paints to avoid reallocation every frame
  static final Paint _gridPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 1.0;
  static final Paint _glowPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 6.0
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
  static final Paint _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Vẽ Lưới (Grid) dạng vệt sáng xanh dương
    final horizontalShader = LinearGradient(
      colors: [
        Colors.transparent,
        const Color(0xFF00C6FF).withOpacity(0.5),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final verticalShader = LinearGradient(
      colors: [
        Colors.transparent,
        const Color(0xFF00C6FF).withOpacity(0.5),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    _gridPaint.shader = horizontalShader;
    for (int i = 1; i < 5; i++) {
      final dy = size.height * i / 5;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), _gridPaint);
    }

    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    const textStyle = TextStyle(
      color: Color(0x99FFFFFF), // White with 0.6 opacity
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );

    _gridPaint.shader = verticalShader;
    final stepX = size.width / (months.length + 1);

    for (int i = 0; i < months.length; i++) {
      final dx = stepX * (i + 1);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height - 20), _gridPaint);

      final textPainter = TextPainter(
        text: const TextSpan(text: '', style: textStyle), // Placeholder to avoid reallocation logic
        textDirection: TextDirection.ltr,
      );
      // We can further optimize by not creating TextPainter every frame, but this is a complex UI part
    }

    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.15, size.height * 0.65),
      Offset(size.width * 0.3, size.height * 0.75),
      Offset(size.width * 0.45, size.height * 0.45),
      Offset(size.width * 0.6, size.height * 0.55),
      Offset(size.width * 0.75, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.25),
      Offset(size.width, size.height * 0.15),
    ];

    final smoothPath = Path();
    smoothPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final cp1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final cp2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      smoothPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
    }

    final pathMetrics = smoothPath.computeMetrics();
    final glowPath = Path();
    final linePath = Path();
    Offset? lastPoint;

    for (final metric in pathMetrics) {
      final length = metric.length;
      final extractLength = length * progress;
      if (extractLength > 0) {
        final extracted = metric.extractPath(0, extractLength);
        glowPath.addPath(extracted, Offset.zero);
        linePath.addPath(extracted, Offset.zero);
        final tangent = metric.getTangentForOffset(extractLength);
        if (tangent != null) lastPoint = tangent.position;
      }
    }

    canvas.drawPath(glowPath, _glowPaint..color = const Color(0xFF00C6FF).withOpacity(0.5));
    canvas.drawPath(linePath, _linePaint..color = const Color(0xFF00C6FF));

    if (lastPoint != null) {
      canvas.drawCircle(lastPoint, 8, Paint()..color = const Color(0xFF00C6FF).withOpacity(0.4)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0));
      canvas.drawCircle(lastPoint, 4, Paint()..color = Colors.white);
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
  State<_SignalsPerformanceCard> createState() =>
      _SignalsPerformanceCardState();
}

class _SignalsPerformanceCardState extends State<_SignalsPerformanceCard>
    with TickerProviderStateMixin {
  late final AnimationController _scrollController;

  @override
  void initState() {
    super.initState();
    // Tốc độ cuộn chậm rãi để người dùng đọc được nội dung (16 giây/vòng)
    _scrollController =
        AnimationController(vsync: this, duration: const Duration(seconds: 16))
          ..repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Nền xám mở rộng (Chỉ hiện trên desktop)
        if (!isMobile)
          Positioned(
            top: -30,
            left: -30,
            right: -30,
            bottom: -30,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

        // 2. Nội dung chính
        _AnimatedBorderCard(
          child: Container(
            width: double.infinity,
            height: isMobile ? 440 : 520,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF0A1020), // Viền xanh đen cực tối, không còn sắc trắng
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF01040D), // Nền xanh đen đặc, tối sẫm
                                                      borderRadius: BorderRadius.circular(7),
                                                    ),
                                                                                            child: Text(
                                                                                              AppLocalizations.of(context)!.signalsPerformanceTitle,
                                                                                              style: AppTextStyles.h3.copyWith(
                                                                                                color: Colors.white,
                                                                                                fontSize: isMobile ? 16 : 17, // Tăng thêm 3 đơn vị (13->16, 14->17)
                                                                                                fontWeight: FontWeight.w400, // Chỉnh xuống w400 cho chữ thanh mảnh hơn
                                                                                              ),
                                                                                            ),                                                  ),
                                                ),
                const SizedBox(height: AppSpacing.lg),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent
                            ],
                            stops: [0.0, 0.1, 0.9, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ClipRect(
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                animation: _scrollController,
                                builder: (context, child) {
                                  return FractionalTranslation(
                                    translation: Offset(0, -_scrollController.value),
                                    child: child,
                                  );
                                },
                                child: _buildList(context, isMobile),
                              ),
                              AnimatedBuilder(
                                animation: _scrollController,
                                builder: (context, child) {
                                  return FractionalTranslation(
                                    translation: Offset(0, 1.0 - _scrollController.value),
                                    child: child,
                                  );
                                },
                                child: _buildList(context, isMobile),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // 3. Lớp phủ đen mờ mở rộng ở đáy
        Positioned(
          left: -31,
          right: -31,
          bottom: -31,
          height: 120,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.9),
                    Colors.black,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, bool isMobile) {
    // Định nghĩa các item
    final items = [
      _PerformanceItem(
        icon: Icons.balance,
        color: const Color(0xFF00C6FF),
        title: AppLocalizations.of(context)!.riskToRewardRatio,
        subtitle: AppLocalizations.of(context)!.howRiskComparesToReward,
      ),
      _PerformanceItem(
        icon: Icons.attach_money,
        color: const Color(0xFF00E676),
        title: AppLocalizations.of(context)!.profitLossOverview,
        subtitle: AppLocalizations.of(context)!.netGainVsLoss,
      ),
      _PerformanceItem(
        icon: Icons.emoji_events,
        color: const Color(0xFFFFD600),
        title: AppLocalizations.of(context)!.winRate,
        subtitle: AppLocalizations.of(context)!.percentageOfWinningTrades,
      ),
      _PerformanceItem(
        icon: Icons.track_changes,
        color: const Color(0xFFFF5252),
        title: AppLocalizations.of(context)!.accuracyRate,
        subtitle: AppLocalizations.of(context)!.howPreciseOurSignalsAre,
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var item in items) ...[
          item,
          const SizedBox(height: 10), // Giảm khoảng cách giữa các thẻ từ 16 xuống 10
        ],
      ],
    );
  }
}

class _PerformanceItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _PerformanceItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 10 : 14), // Giảm padding từ 12/18 xuống 10/14
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF020617).withOpacity(0.5), 
                  const Color(0xFF0A0F1E).withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.05)), // Viền mờ hơn nữa
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon trực tiếp, không có nền tròn, kích thước lớn hơn
          Icon(icon, color: Colors.white.withOpacity(0.8), size: isMobile ? 26 : 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h3.copyWith(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.body.copyWith(
                    fontSize: isMobile ? 12 : 13,
                    color: Colors.white54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
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
                              constraints: const BoxConstraints(minHeight: 520, maxWidth: 500),
                              child: const SizedBox(
                                width: double.infinity,
                                child: _SignalsPerformanceCard(),
                              ),
                            ),
                          ),
                        ),        const SizedBox(width: 25),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140), // Hạ thấp card bên phải thêm nữa
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minHeight: 520, maxWidth: 650),
                                    child: const SizedBox(
                                      width: double.infinity,
                                      child: _TransparentCardAnimated(),
                                    ),
                                  ),
                                ),                  ),
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
            height: 28, // Match Live Signals
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
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
            padding: const EdgeInsets.all(1.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.aiSignal,
                style: AppTextStyles.bodyBold.copyWith(
                  color: Colors.white,
                  fontSize: 14, // Match Live Signals
                  fontWeight: FontWeight.w600, // Figma: w600
                  letterSpacing: -0.54, // Figma: -0.90
                  height: 1.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(BuildContext context, String text, bool isMobile, {double? width}) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    return Container(
      width: isMobile ? null : ((isEnglish && !isMobile) ? width : null), 
      height: isMobile ? 28 : 35, 
      padding: isMobile 
          ? const EdgeInsets.symmetric(horizontal: 16)
          : ((!isMobile && !isEnglish) ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 2 : 6),
        border: Border.all(color: Colors.white, width: isMobile ? 0.8 : 1),
        color: Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTextStyles.bodyBold.copyWith(
          color: Colors.white,
          fontSize: isMobile ? 14 : 18, // Figma: 18
          fontWeight: FontWeight.w600, // Figma: w600
          letterSpacing: -0.54, // Figma: -0.90
          height: 1.1,
        ),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF020202), // Nền màu đen nguyên bản
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 2.0,
                  colors: [
                    const Color(0xFF2E60FF).withOpacity(0.25),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: isMobile ? 32 : 48,
              top: isMobile ? 32 : 48,
              right: isMobile ? 20 : 32,
              bottom: isMobile ? 20 : 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    // Thay đổi logic cũ (trái/phải) thành trượt lên
    _slide = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(
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
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: const Color(0xFF2E60FF).withOpacity(0.6),
                          blurRadius: 24,
                          spreadRadius: 4,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : [],
              ),
              child: _AnimatedBorderCard(
                child: _CoreValueCard(
                  title: widget.title,
                  description: widget.description,
                ),
              ),
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
    return _AnswerShimmer(
      borderRadius: 10,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: ExpansionTile(
          shape: const Border(), // Loại bỏ viền khi mở rộng
          collapsedShape: const Border(), // Loại bỏ viền khi thu gọn
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(question,
              style: AppTextStyles.body.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          children: [
            Divider(
              color: Colors.white.withOpacity(0.08),
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  answer.isEmpty ? 'Content updating...' : answer,
                  style: AppTextStyles.caption
                      .copyWith(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerShimmer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  const _AnswerShimmer({required this.child, this.borderRadius = 0});

  @override
  State<_AnswerShimmer> createState() => _AnswerShimmerState();
}

class _AnswerShimmerState extends State<_AnswerShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Chậm hơn để vệt sáng lớn trôi mượt mà
    )..repeat(reverse: true);
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
        final curvedValue = Curves.easeInOutSine.transform(_controller.value);
        // Mở rộng range để vệt sáng cực rộng có thể di chuyển hết qua thẻ
        final center = -1.5 + (curvedValue * 4.0);

        return Container(
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                // Màu xanh đậm hơn (opacity 0.4) để tạo chiều sâu
                const Color(0xFF2E60FF).withOpacity(0.4), 
                Colors.transparent,
              ],
              // Độ lan tỏa cực rộng (+/- 0.9) tạo cảm giác ánh sáng bao phủ
              stops: [
                center - 0.9, 
                center,
                center + 0.9,
              ],
              begin: const Alignment(-1.5, -1.0), 
              end: const Alignment(1.5, 2.5), 
            ),
          ),
          child: widget.child,
        );
      },
      child: widget.child,
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
