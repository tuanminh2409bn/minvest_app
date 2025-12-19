import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';

class SignalsBackground extends StatefulWidget {
  final Widget child;
  const SignalsBackground({super.key, required this.child});

  @override
  State<SignalsBackground> createState() => _SignalsBackgroundState();
}

class _SignalsBackgroundState extends State<SignalsBackground> with SingleTickerProviderStateMixin {
  // Initial rotation values for the 6 positions
  final List<double> _rotations = [-2, 1, -3, -2, 1, -3];

  // Pool of signal data to cycle through
  final List<_SignalCardData> _signalPool = const [
    _SignalCardData(pair: 'XAU/USD', side: 'Sell Limit', isBuy: false, icon: Icons.monetization_on),
    _SignalCardData(pair: 'BTC/USD', side: 'Buy Limit', isBuy: true, icon: Icons.currency_bitcoin),
    _SignalCardData(pair: 'EUR/USD', side: 'Buy Limit', isBuy: true, icon: Icons.euro),
    _SignalCardData(pair: 'GBP/JPY', side: 'Sell Limit', isBuy: false, icon: Icons.currency_pound),
    _SignalCardData(pair: 'US30', side: 'Buy Limit', isBuy: true, icon: Icons.show_chart),
    _SignalCardData(pair: 'ETH/USD', side: 'Sell Limit', isBuy: false, icon: Icons.token),
  ];

  // State to track which data index is currently showing for each card position
  late List<int> _currentDataIndices;

  @override
  void initState() {
    super.initState();
    // Initialize with 0, 1, 2, 3, 4, 5
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
        // Limit content width logic similar to FeaturesPage
        final double contentWidth = math.min(screenWidth, 1200.0);
        final bool isNarrow = contentWidth < 900;
        
        // Calculate positions: +60 as requested by user
        final double cardOffset = (screenWidth - contentWidth) / 2 + 60;

        // Minimum height to ensure cards are visible
        final double minHeight = isNarrow ? 520 : 640;

        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // 1. Glow Background (Bottom) - Focused behind the form
              const _GlowBackground(width: 800),

              // 2. Interactive Cards (Middle)
              if (!isNarrow)
                Positioned(
                  top: 200,
                  left: cardOffset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[0]],
                        rotation: _rotations[0],
                        onTap: () => _cycleCardContent(0),
                      ),
                      const SizedBox(height: 64),
                      _InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[1]],
                        rotation: _rotations[1],
                        onTap: () => _cycleCardContent(1),
                      ),
                      const SizedBox(height: 64),
                      _InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[2]],
                        rotation: _rotations[2],
                        onTap: () => _cycleCardContent(2),
                      ),
                    ],
                  ),
                ),
              if (!isNarrow)
                Positioned(
                  top: 200,
                  right: cardOffset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[3]],
                        rotation: _rotations[3],
                        onTap: () => _cycleCardContent(3),
                      ),
                      const SizedBox(height: 64),
                      _InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[4]],
                        rotation: _rotations[4],
                        onTap: () => _cycleCardContent(4),
                      ),
                      const SizedBox(height: 64),
                      _InteractiveSignalCard(
                        data: _signalPool[_currentDataIndices[5]],
                        rotation: _rotations[5],
                        onTap: () => _cycleCardContent(5),
                      ),
                    ],
                  ),
                ),

              // 3. Child (Form) (Top)
              // Stack sizes itself to non-positioned children.
              // We constrain the child width but let height determine Stack height (if > minHeight).
              Container(
                constraints: BoxConstraints(maxWidth: contentWidth),
                alignment: Alignment.center,
                child: widget.child,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SignalCardData {
  final String pair;
  final String side;
  final bool isBuy;
  final IconData icon;

  const _SignalCardData({
    required this.pair,
    required this.side,
    required this.isBuy,
    required this.icon,
  });
}

class _InteractiveSignalCard extends StatefulWidget {
  final _SignalCardData data;
  final double rotation;
  final VoidCallback onTap;

  const _InteractiveSignalCard({
    required this.data,
    required this.rotation,
    required this.onTap,
  });

  @override
  State<_InteractiveSignalCard> createState() => _InteractiveSignalCardState();
}

class _InteractiveSignalCardState extends State<_InteractiveSignalCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
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
    final currentRotation = _isHovered ? widget.rotation + 2.0 : widget.rotation;

    return MouseRegion(
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
    );
  }
}

class _GlowBackground extends StatelessWidget {
  final double? width;
  const _GlowBackground({this.width});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: width,
          child: Opacity(
            opacity: 0.85,
            child: Image.asset(
              'assets/mockups/light.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}