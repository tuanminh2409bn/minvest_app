import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:minvest_forex_app/web/theme/colors.dart';
import 'package:minvest_forex_app/web/theme/spacing.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/l10n/app_localizations.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:minvest_forex_app/web/theme/gradients.dart';
import 'package:minvest_forex_app/web/chat/web_chat_bubble.dart';
import 'package:minvest_forex_app/web/theme/breakpoints.dart';
import 'package:minvest_forex_app/web/widgets/signal_history_table.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: isMobile ? const TextScaler.linear(0.6) : const TextScaler.linear(1.0),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: const WebChatBubble(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const _ContentWrapper(child: LandingNavBar()),
              const SizedBox(height: 24),
              const WinMoreSection(),
              SizedBox(height: isMobile ? 48 : 96),
              const _ContentWrapper(child: SmartToolsSection()),
              SizedBox(height: isMobile ? 48 : 96),
              const _ContentWrapper(child: YourOnDemandSection()),
              SizedBox(height: isMobile ? 48 : 96),
              const _ContentWrapper(child: MaximizeResultsSection()),
              SizedBox(height: isMobile ? 24 : 48),
              const _ContentWrapper(child: FooterSection()),
            ],
          ),
        ),
      ),
    );
  }
}

class WinMoreSection extends StatefulWidget {
  const WinMoreSection({super.key});

  @override
  State<WinMoreSection> createState() => _WinMoreSectionState();
}

class _WinMoreSectionState extends State<WinMoreSection> with SingleTickerProviderStateMixin {
  int hoveredIndex = -1;
  int _textHoverIndex = -1;

  // Initial rotation values for the 6 positions
  final List<double> _rotations = [-2, 1, -3, -2, 1, -3];

  // Pool of signal data to cycle through
  final List<_SignalCardData> _signalPool = const [
    _SignalCardData(pair: 'XAU/USD', side: 'Sell Limit', isBuy: false, icon: Icons.monetization_on),
    _SignalCardData(pair: 'BTC/USDT', side: 'Buy Limit', isBuy: true, icon: Icons.currency_bitcoin),
    _SignalCardData(pair: 'EUR/USD', side: 'Buy Limit', isBuy: true, icon: Icons.euro),
    _SignalCardData(pair: 'GBP/JPY', side: 'Sell Limit', isBuy: false, icon: Icons.currency_pound),
    _SignalCardData(pair: 'US30', side: 'Buy Limit', isBuy: true, icon: Icons.show_chart),
    _SignalCardData(pair: 'ETH/USDT', side: 'Sell Limit', isBuy: false, icon: Icons.token),
  ];

  // State to track which data index is currently showing for each card position
  late List<int> _currentDataIndices;

  @override
  void initState() {
    super.initState();
    // Initialize with 0, 1, 2, 3, 4, 5
    _currentDataIndices = List.generate(6, (index) => index % _signalPool.length);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _cycleCardContent(int cardIndex) {
    setState(() {
      _currentDataIndices[cardIndex] = (_currentDataIndices[cardIndex] + 1) % _signalPool.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          _ContentWrapper(
            child: Text(
              AppLocalizations.of(context)!.winMoreWithAiSignalsTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 36),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          LayoutBuilder(
            builder: (context, constraints) {
              final double screenWidth = constraints.maxWidth;
              final double contentWidth = math.min(screenWidth, 1200.0);
              final bool isNarrow = contentWidth < 900;
              
              // Calculate positions
              // Moving cards significantly inside to be partially behind the phone (+380)
              final double cardOffset = (screenWidth - contentWidth) / 2 + 150;

              return SizedBox(
                height: isNarrow ? 520 : 640,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // 1. Glow Background (Bottom)
                    _GlowBackground(width: contentWidth * 1.5),

                    // 2. Interactive Cards (Middle) - Behind phone, above glow
                    if (!isNarrow)
                      Positioned(
                        top: 160,
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
                        top: 160,
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

                    // 3. Phone Mockup (Top)
                    _PhoneMockup(
                      onHoverStart: (index) {},
                      onHoverEnd: (index) {},
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          _ContentWrapper(
            child: Text(
              AppLocalizations.of(context)!.winMoreWithAiSignalsDesc,
              style: AppTextStyles.body.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _ContentWrapper(
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/signup'),
                child: Container(
                  padding: const EdgeInsets.all(1.2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.startNow,
                      style: AppTextStyles.h3.copyWith(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
    // Determine rotation: if hovered, slightly adjust rotation for effect
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
                  borderRadius: BorderRadius.circular(6), // Changed to 6px
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
                    // Icon color #289EFF
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

class _PhoneMockup extends StatelessWidget {
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;
  const _PhoneMockup({super.key, required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        // Giữ tỷ lệ 1:2 nhưng co lại trên mobile để vừa khung
        final width = maxW < 360 ? maxW * 0.82 : maxW < 540 ? maxW * 0.66 : 320.0;
        final height = width * 2;

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _PhoneFrame(),
              _PhoneScreenHolder(
                width: width,
                height: height,
                onHoverStart: onHoverStart,
                onHoverEnd: onHoverEnd,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/mockups/iPhone16.png', fit: BoxFit.contain);
  }
}

class _PhoneScreenHolder extends StatelessWidget {
  final double width;
  final double height;
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;
  const _PhoneScreenHolder({
    required this.width,
    required this.height,
    required this.onHoverStart,
    required this.onHoverEnd,
  });

  @override
  Widget build(BuildContext context) {
    // Tăng inset để màn hình trong nhỏ hơn khung một chút
    final horizontalInset = width * 0.06;
    final topInset = height * 0.06;
    final bottomInset = height * 0.05;

    return Positioned.fill(
      left: horizontalInset,
      right: horizontalInset,
      top: topInset,
      bottom: bottomInset,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
        child: _PhoneScreen(
          onHoverStart: onHoverStart,
          onHoverEnd: onHoverEnd,
        ),
      ),
    );
  }
}

class _PhoneScreen extends StatelessWidget {
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;

  const _PhoneScreen({required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    final List<_SignalRowData> rows = [
      _SignalRowData(icon: Icons.water_drop, pair: 'WTI', side: 'Buy Limit'),
      _SignalRowData(icon: Icons.currency_bitcoin, pair: 'XAU/USD', side: 'Sell Limit'),
      _SignalRowData(icon: Icons.currency_exchange, pair: 'DXY/USDT', side: 'Buy Limit'),
      _SignalRowData(icon: Icons.account_balance, pair: 'XAU/USD', side: 'Sell Limit'),
      _SignalRowData(icon: Icons.euro, pair: 'EUR/USD', side: 'Buy Limit'),
      _SignalRowData(icon: Icons.currency_bitcoin, pair: 'BTC/USDT', side: 'Sell Limit'),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPad = constraints.maxWidth * 0.035; // co giãn theo khung
        final verticalPad = constraints.maxHeight * 0.025;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPad.clamp(10, 16), vertical: verticalPad.clamp(10, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('9:41', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 12)),
                    const Spacer(),
                    const Icon(Icons.wifi, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    const Icon(Icons.battery_full, size: 14, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                const Icon(Icons.arrow_back, color: Colors.white, size: 16),
                const SizedBox(height: 10),
                Text('AI Signals', style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _chip('Gold', true),
                      const SizedBox(width: 6),
                      _chip('Forex', false),
                      const SizedBox(width: 6),
                      _chip('Crypto', false),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: rows.length,
                    itemBuilder: (context, index) {
                      final r = rows[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF242424)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(r.icon, color: const Color(0xFF00A7FF), size: 18),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r.pair, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                    Text('Update: dd/mm/yyyy', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 10)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              MouseRegion(
                                onEnter: (_) => onHoverStart(index),
                                onExit: (_) => onHoverEnd(index),
                                child: Text(
                                  r.side,
                                  style: AppTextStyles.body.copyWith(
                                    color: r.side.toLowerCase().contains('buy') ? Colors.greenAccent : Colors.redAccent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
        );
      },
    );
  }

  Widget _chip(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2D2D2D) : const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SignalRowData {
  final IconData icon;
  final String pair;
  final String side;
  const _SignalRowData({required this.icon, required this.pair, required this.side});
}



class SmartToolsSection extends StatefulWidget {
  const SmartToolsSection({super.key});

  @override
  State<SmartToolsSection> createState() => _SmartToolsSectionState();
}

class _SmartToolsSectionState extends State<SmartToolsSection> with SingleTickerProviderStateMixin {
  bool _isFlipped = false;
  late AnimationController _flipController;
  late Animation<double> _frontAnimation;
  late Animation<double> _backAnimation;

  final List<HistoryRow> _demoHistoryRows = List.generate(8, (index) {
    return HistoryRow(
      date: '28/10/2025',
      time: '10:${10 + index}',
      asset: index % 2 == 0 ? 'GOLD' : 'BTC/USDT',
      order: index % 2 == 0 ? 'BUY' : 'SELL',
      status: index % 3 == 0 ? 'TP1' : (index % 3 == 1 ? 'TP2' : 'SL'),
      pips: index % 3 == 2 ? '-50' : '+120',
      entry: '203${index}',
      sl: '2020',
      tp1: '2040',
      tp2: '2050',
    );
  });

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    
    // Create sequence for front side: 0 -> 90 degrees (disappear)
    _frontAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -math.pi / 2), weight: 50),
      TweenSequenceItem(tween: ConstantTween(-math.pi / 2), weight: 50),
    ]).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));

    // Create sequence for back side: -90 degrees -> 0 (appear)
    _backAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(math.pi / 2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: math.pi / 2, end: 0.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
      if (_isFlipped) {
        _flipController.forward();
      } else {
        _flipController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.smarterToolsTitle,
            style: AppTextStyles.h1.copyWith(fontSize: 36),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppLocalizations.of(context)!.smarterToolsDesc,
            style: AppTextStyles.body.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          
          // Flip Container
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _toggleFlip,
              child: Stack(
                children: [
                  // Front Side
                  AnimatedBuilder(
                    animation: _frontAnimation,
                    builder: (context, child) {
                      final angle = _frontAnimation.value;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(angle),
                        alignment: Alignment.center,
                        child: angle < -math.pi / 2 + 0.01 ? const SizedBox.shrink() : _buildFrontSide(context),
                      );
                    },
                  ),
                  // Back Side
                  AnimatedBuilder(
                    animation: _backAnimation,
                    builder: (context, child) {
                      final angle = _backAnimation.value;
                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(angle),
                        alignment: Alignment.center,
                        child: angle > math.pi / 2 - 0.01 ? const SizedBox.shrink() : _buildBackSide(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontSide(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0C132A), Color(0xFF0A0E1F)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: const [
              Icon(Icons.circle, size: 10, color: Colors.white24),
              SizedBox(width: 8),
              Icon(Icons.circle, size: 10, color: Colors.white24),
              SizedBox(width: 8),
              Icon(Icons.circle, size: 10, color: Colors.white24),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: const [
                    Icon(Icons.circle, size: 10, color: Colors.white30),
                    SizedBox(width: 6),
                    Icon(Icons.circle, size: 10, color: Colors.white30),
                    SizedBox(width: 6),
                    Icon(Icons.circle, size: 10, color: Colors.white30),
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.white12),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.performanceOverviewTitle,
                      style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      AppLocalizations.of(context)!.performanceOverviewDesc,
                      style: AppTextStyles.body.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isNarrow = constraints.maxWidth < 900;
                        if (isNarrow) {
                          return Column(
                            children: [
                              _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.totalProfit,
                                value: '9,250.8 pips',
                              ),
                              const SizedBox(height: 12),
                              _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.completionSignal,
                                value: '507',
                              ),
                              const SizedBox(height: 12),
                              _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.winRate,
                                value: '62.7%',
                              ),
                              const SizedBox(height: 12),
                              const _AnimatedStatCard(
                                title: 'Active Member',
                                value: '+10,566',
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Expanded(
                              child: _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.totalProfit,
                                value: '9,250.8 pips',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.completionSignal,
                                value: '507',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _AnimatedStatCard(
                                title: AppLocalizations.of(context)!.winRate,
                                value: '62.7%',
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: _AnimatedStatCard(
                                title: 'Active Member',
                                value: '+10,566',
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackSide(BuildContext context) {
    // Reusing the same container style but showing history table
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0C132A), Color(0xFF0A0E1F)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.circle, size: 10, color: Colors.white24),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 10, color: Colors.white24),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 10, color: Colors.white24),
              const Spacer(),
              Text(
                'Signal History',
                style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SignalHistoryTable(rows: _demoHistoryRows),
          ),
        ),
      ],
    );
  }
}

class _AnimatedStatCard extends StatefulWidget {
  final String title;
  final String value;
  const _AnimatedStatCard({required this.title, required this.value});

  @override
  State<_AnimatedStatCard> createState() => _AnimatedStatCardState();
}

class _AnimatedStatCardState extends State<_AnimatedStatCard> with SingleTickerProviderStateMixin {
  late final AnimationController _borderController;

  @override
  void initState() {
    super.initState();
    _borderController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _borderController,
      builder: (context, child) {
        final t = _borderController.value;
        final colors = const [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)];
        // Create a shifting gradient
        final stops = [
          (t + 0.0) % 1,
          (t + 0.33) % 1,
          (t + 0.66) % 1,
        ]..sort();
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: colors,
              stops: stops,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00BFFF).withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Text(
                  widget.value,
                  style: AppTextStyles.h1.copyWith(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF00BFFF)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class YourOnDemandSection extends StatelessWidget {
  const YourOnDemandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < Breakpoints.tablet;

    return Column(
      children: [
        SizedBox(height: isMobile ? 0 : 48),
        Column(
          children: [
            Text(
              AppLocalizations.of(context)!.onDemandFinancialExpertTitle,
              style: AppTextStyles.h1.copyWith(fontSize: 36),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppLocalizations.of(context)!.onDemandFinancialExpertDesc,
              style: AppTextStyles.body.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(height: isMobile ? 40 : 150),
        const _LaptopShowcase(),
      ],
    );
  }
}

class _LaptopShowcase extends StatelessWidget {
  const _LaptopShowcase();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxW = constraints.maxWidth;
        final bool isNarrow = maxW < 900;
        final double laptopWidth = isNarrow ? maxW * 1.25 : (maxW < 1200 ? maxW * 0.9 : 1100);
        final double height = isNarrow ? maxW : 640;
        final double offsetY = isNarrow ? 0 : -30;

        if (isNarrow) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    const _LaptopGlow(),
                    _LaptopImage(width: laptopWidth, offsetY: offsetY),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _LaptopCardsInline(maxWidth: maxW),
            ],
          );
        }

        return SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              const _LaptopGlow(),
              _LaptopImage(width: laptopWidth, offsetY: offsetY),
              _LaptopCards(availableWidth: laptopWidth),
            ],
          ),
        );
      },
    );
  }
}

class _LaptopGlow extends StatelessWidget {
  const _LaptopGlow();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1.3,
            heightFactor: 1.0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/mockups/light.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LaptopImage extends StatelessWidget {
  final double width;
  final double offsetY;
  const _LaptopImage({required this.width, required this.offsetY});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Transform.translate(
        offset: Offset(0, offsetY),
        child: SizedBox(
          width: width,
          child: Image.asset(
            'assets/mockups/laptop.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _LaptopCards extends StatelessWidget {
  final double availableWidth;
  const _LaptopCards({required this.availableWidth});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isNarrow = constraints.maxWidth < 900;
          final double baseW = constraints.maxWidth;
          final double cardWidth = isNarrow ? baseW * 0.6 : 440;
          final double cardHeight = isNarrow ? 72 : 108;

          if (isNarrow) {
            return Column(
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _AnimatedInfoCard(
                    text: AppLocalizations.of(context)!.aiPoweredSignalPlatform,
                    slideFromLeft: true,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: cardWidth,
                  child: _AnimatedInfoCard(
                    text: AppLocalizations.of(context)!.selfLearningSystems,
                    slideFromLeft: false,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: cardWidth,
                  child: _AnimatedInfoCard(
                    text: AppLocalizations.of(context)!.emotionlessExecution,
                    slideFromLeft: true,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: cardWidth,
                  child: _AnimatedInfoCard(
                    text: AppLocalizations.of(context)!.analysingMarket247,
                    slideFromLeft: false,
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              Row(
                children: [
                  _AnimatedInfoCard(text: AppLocalizations.of(context)!.aiPoweredSignalPlatform, slideFromLeft: true, width: cardWidth, height: cardHeight),
                  SizedBox(width: 16),
                  _AnimatedInfoCard(text: AppLocalizations.of(context)!.selfLearningSystems, slideFromLeft: false, width: cardWidth, height: cardHeight),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _AnimatedInfoCard(text: AppLocalizations.of(context)!.emotionlessExecution, slideFromLeft: true, width: cardWidth, height: cardHeight),
                  SizedBox(width: 16),
                  _AnimatedInfoCard(text: AppLocalizations.of(context)!.analysingMarket247, slideFromLeft: false, width: cardWidth, height: cardHeight),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LaptopCardsInline extends StatelessWidget {
  final double maxWidth;
  const _LaptopCardsInline({required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    final double cardWidth = maxWidth * 0.8;
    const double cardHeight = 76;
    return Column(
      children: [
        SizedBox(
          width: cardWidth,
          child: _AnimatedInfoCard(
            text: AppLocalizations.of(context)!.aiPoweredSignalPlatform,
            slideFromLeft: true,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: cardWidth,
          child: _AnimatedInfoCard(
            text: AppLocalizations.of(context)!.selfLearningSystems,
            slideFromLeft: false,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: cardWidth,
          child: _AnimatedInfoCard(
            text: AppLocalizations.of(context)!.emotionlessExecution,
            slideFromLeft: true,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: cardWidth,
          child: _AnimatedInfoCard(
            text: AppLocalizations.of(context)!.analysingMarket247,
            slideFromLeft: false,
            width: cardWidth,
            height: cardHeight,
          ),
        ),
      ],
    );
  }
}

class _AnimatedInfoCard extends StatefulWidget {
  final String text;
  final bool slideFromLeft;
  final double width;
  final double height;
  const _AnimatedInfoCard({
    required this.text,
    required this.slideFromLeft,
    this.width = 440,
    this.height = 108,
  });

  @override
  State<_AnimatedInfoCard> createState() => _AnimatedInfoCardState();
}

class _AnimatedInfoCardState extends State<_AnimatedInfoCard> with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final AnimationController _borderController;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _borderController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _slide = Tween(
      begin: Offset(widget.slideFromLeft ? -0.18 : 0.18, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic));
    _fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _entryController.dispose();
    _borderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isNarrow = MediaQuery.of(context).size.width < 900;
    return VisibilityDetector(
      key: ValueKey('info_card_${widget.text}'),
      onVisibilityChanged: (info) {
        if (!_hasPlayed && info.visibleFraction > 0.2) {
          _hasPlayed = true;
          _entryController.forward(from: 0);
        }
      },
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: AnimatedBuilder(
            animation: _borderController,
            builder: (context, child) {
              final t = _borderController.value;
              final colors = const [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)];
              final stops = [
                (t + 0.0) % 1,
                (t + 0.4) % 1,
                (t + 0.8) % 1,
              ]..sort();
              return Container(
                width: widget.width,
                height: widget.height,
                padding: const EdgeInsets.all(1.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: colors,
                    stops: stops,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors[1].withOpacity(0.25),
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Center(
                child: Text(
                  widget.text,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontSize: isNarrow ? 14 : 15,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MaximizeResultsSection extends StatelessWidget {
  const MaximizeResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.maximizeResultsFeaturesTitle,
            style: AppTextStyles.h1.copyWith(fontSize: 36),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            AppLocalizations.of(context)!.minvestAiRegistrationDesc,
            style: AppTextStyles.body.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          _ctaButton(),
        ],
      ),
    );
  }

  Widget _ctaButton() {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed('/signup'),
        child: Container(
          padding: const EdgeInsets.all(1.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Color(0xFF04B3E9), Color(0xFF2E60FF), Color(0xFFD500F9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              AppLocalizations.of(context)!.startNow,
              style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentWrapper extends StatelessWidget {
  final Widget child;
  const _ContentWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: LayoutBuilder(
          builder: (context, constraints) {
             final bool isNarrow = MediaQuery.of(context).size.width < 900;
             return Padding(
               padding: EdgeInsets.symmetric(horizontal: isNarrow ? 12 : 0),
               child: child,
             );
          },
        ),
      ),
    );
  }
}
