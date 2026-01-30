import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';

class LandingBackgroundWrapper extends StatefulWidget {
  final Widget child;
  final double paddingTop;
  final double offsetAdjustment;

  const LandingBackgroundWrapper({
    super.key,
    required this.child,
    this.paddingTop = 0,
    this.offsetAdjustment = 100,
  });

  @override
  State<LandingBackgroundWrapper> createState() => _LandingBackgroundWrapperState();
}

class _LandingBackgroundWrapperState extends State<LandingBackgroundWrapper> {
  // Initial rotation values for the 6 positions
  final List<double> _rotations = [-2, 1, -3, -2, 1, -3];

  // Pool of signal data to cycle through
  final List<SignalCardData> _signalPool = const [
    SignalCardData(pair: 'XAU/USD', side: 'Sell Limit', isBuy: false, icon: Icons.monetization_on),
    SignalCardData(pair: 'BTC/USDT', side: 'Buy Limit', isBuy: true, icon: Icons.currency_bitcoin),
    SignalCardData(pair: 'EUR/USD', side: 'Buy Limit', isBuy: true, icon: Icons.euro),
    SignalCardData(pair: 'GBP/JPY', side: 'Sell Limit', isBuy: false, icon: Icons.currency_pound),
    SignalCardData(pair: 'US30', side: 'Buy Limit', isBuy: true, icon: Icons.show_chart),
    SignalCardData(pair: 'ETH/USDT', side: 'Sell Limit', isBuy: false, icon: Icons.token),
  ];

  late List<int> _currentDataIndices;

  @override
  void initState() {
    super.initState();
    _currentDataIndices = List.generate(6, (index) => index % _signalPool.length);
  }

  void _cycleCardContent(int cardIndex) {
    setState(() {
      _currentDataIndices[cardIndex] = (_currentDataIndices[cardIndex] + 1) % _signalPool.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        // Logic from features_page.dart
        final double contentWidth = math.min(screenWidth, 1200.0);
        final bool isNarrow = contentWidth < 900;

        // Calculate positions
        final double cardOffset = (screenWidth - contentWidth) / 2 + widget.offsetAdjustment;

        final double minHeight = isNarrow ? 520 : 640;

        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // 1. Glow Background (Bottom)
              GlowBackground(
                width: isNarrow ? screenWidth * 1.2 : contentWidth * 1.5,
                height: isNarrow ? 400 : 550,
              ),

              // 2. Interactive Cards (Middle) - Behind child, above glow
              if (!isNarrow)
                Positioned(
                  top: widget.paddingTop + 160,
                  left: cardOffset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[0]],
                        rotation: _rotations[0],
                        onTap: () => _cycleCardContent(0),
                      ),
                      const SizedBox(height: 64),
                      InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[1]],
                        rotation: _rotations[1],
                        onTap: () => _cycleCardContent(1),
                      ),
                      const SizedBox(height: 64),
                      InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[2]],
                        rotation: _rotations[2],
                        onTap: () => _cycleCardContent(2),
                      ),
                    ],
                  ),
                ),
              if (!isNarrow)
                Positioned(
                  top: widget.paddingTop + 160,
                  right: cardOffset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[3]],
                        rotation: _rotations[3],
                        onTap: () => _cycleCardContent(3),
                      ),
                      const SizedBox(height: 64),
                      InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[4]],
                        rotation: _rotations[4],
                        onTap: () => _cycleCardContent(4),
                      ),
                      const SizedBox(height: 64),
                      InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[5]],
                        rotation: _rotations[5],
                        onTap: () => _cycleCardContent(5),
                      ),
                    ],
                  ),
                ),

              // 3. Main Child (Phone or Form)
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

class SignalCardData {
  final String pair;
  final String side;
  final bool isBuy;
  final IconData icon;

  const SignalCardData({
    required this.pair,
    required this.side,
    required this.isBuy,
    required this.icon,
  });
}

class InteractiveSignalCard extends StatefulWidget {
  final SignalCardData data;
  final double rotation;
  final VoidCallback onTap;

  const InteractiveSignalCard({
    super.key,
    required this.data,
    required this.rotation,
    required this.onTap,
  });

  @override
  State<InteractiveSignalCard> createState() => _InteractiveSignalCardState();
}

class _InteractiveSignalCardState extends State<InteractiveSignalCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Seesaw rotation effect
    _rotateAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
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
      child: MouseRegion(
        onEnter: (_) {
          Future.delayed(Duration.zero, () {
            if (mounted) {
              setState(() => _isHovered = true);
              _controller.forward();
            }
          });
        },
        onExit: (_) {
          Future.delayed(Duration.zero, () {
            if (mounted) {
              setState(() => _isHovered = false);
              _controller.reverse();
            }
          });
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final currentRotation = widget.rotation + _rotateAnimation.value;

              return Transform(
                transform: Matrix4.identity()
                  ..rotateZ(currentRotation * math.pi / 180)
                  ..scale(_scaleAnimation.value),
                alignment: Alignment.center,
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141414),
                    borderRadius: BorderRadius.circular(6),
                    // Logic from FeaturesPage: Add Blue border on Hover
                    border: Border.all(
                      color: _isHovered ? const Color(0xFF289EFF) : Colors.white12,
                      width: _isHovered ? 2.0 : 1.0,
                    ),
                    boxShadow: [
                      if (_isHovered)
                        BoxShadow(
                          color: const Color(0xFF289EFF).withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      const BoxShadow(
                        color: Colors.black45,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(widget.data.icon, color: const Color(0xFF289EFF), size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data.pair,
                              style: AppTextStyles.h3.copyWith(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Update: dd/mm/yyyy',
                              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.data.side,
                        style: AppTextStyles.body.copyWith(
                          color: widget.data.isBuy ? const Color(0xFF3CFF00) : Colors.redAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class GlowBackground extends StatelessWidget {
  final double? width;
  final double? height;
  const GlowBackground({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final w = width ?? 800;
    final h = height ?? 600;

    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: w,
          height: h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Blue Light (Left-ish)
              Transform.translate(
                offset: Offset(-w * 0.05, 0),
                child: Container(
                  width: w * 0.6,
                  height: h * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF2E60FF).withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E60FF).withOpacity(0.4),
                        blurRadius: 120,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
              // Purple/Pink Light (Right-ish)
              Transform.translate(
                offset: Offset(w * 0.05, 0),
                child: Container(
                  width: w * 0.6,
                  height: h * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFBF4ED2).withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFBF4ED2).withOpacity(0.3),
                        blurRadius: 120,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
