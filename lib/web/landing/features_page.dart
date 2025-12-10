import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:minvest_forex_app/web/theme/colors.dart';
import 'package:minvest_forex_app/web/theme/spacing.dart';
import 'package:minvest_forex_app/web/theme/text_styles.dart';
import 'package:minvest_forex_app/web/landing/widgets/navbar.dart';
import 'package:minvest_forex_app/web/landing/sections/footer_section.dart';
import 'package:minvest_forex_app/web/theme/gradients.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isNarrow = constraints.maxWidth < 900;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: isNarrow ? 12 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      const LandingNavBar(),
                      const SizedBox(height: 24),
                      const WinMoreSection(),
                      SizedBox(height: isNarrow ? 64 : 96),
                      const SmartToolsSection(),
                      SizedBox(height: isNarrow ? 64 : 96),
                      const YourOnDemandSection(),
                      SizedBox(height: isNarrow ? 64 : 96),
                      const MaximizeResultsSection(),
                      const SizedBox(height: 48),
                      const FooterSection(),
                    ],
                  ),
                );
              },
            ),
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
  late final AnimationController _hoverController;
  int _textHoverIndex = -1;

  final List<_CardData> cards = const [
    _CardData(image: 'assets/mockups/card1.png', rotation: -2),
    _CardData(image: 'assets/mockups/card2.png', rotation: 1),
    _CardData(image: 'assets/mockups/card3.png', rotation: -3),
    _CardData(image: 'assets/mockups/card4.png', rotation: -5),
    _CardData(image: 'assets/mockups/card5.png', rotation: -10),
    _CardData(image: 'assets/mockups/card6.png', rotation: -8),
  ];

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(
            'Win More with AI-Powered Signals\nin Every Market',
            style: AppTextStyles.h1.copyWith(fontSize: 28, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          LayoutBuilder(
            builder: (context, constraints) {
              final bool isNarrow = constraints.maxWidth < 900;
              return SizedBox(
                height: isNarrow ? 520 : 640,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    const _GlowBackground(),
                    if (!isNarrow)
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: false,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -220,
                                top: 120,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _floatingCard(0, offsetY: -60),
                                    const SizedBox(height: 16),
                                    _floatingCard(1, offsetY: 0),
                                    const SizedBox(height: 16),
                                    _floatingCard(2, offsetY: 40),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -220,
                                top: 100,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _floatingCard(3, offsetY: -60),
                                    const SizedBox(height: 16),
                                    _floatingCard(4, offsetY: 0),
                                    const SizedBox(height: 16),
                                    _floatingCard(5, offsetY: 40),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    _PhoneMockup(
                      onHoverStart: (index) => _startTextHover(index),
                      onHoverEnd: (index) => _endTextHover(index),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Our multi-market AI scans Forex, Crypto, and Metals in real-time,\n'
                'delivering expert-validated trading signals —\n'
                'with clear entry, stop-loss, and take-profit levels.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('/signup'),
              child: Container(
                padding: const EdgeInsets.all(1.2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00BFFF), Color(0xFFD500F9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Text(
                    'Get Signals now',
                    style: AppTextStyles.h3.copyWith(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingCard(int index, {double offsetY = 0}) {
    final data = cards[index];
    final activeIndex = hoveredIndex != -1 ? hoveredIndex : _textHoverIndex;
    final isActive = activeIndex == index;
    return MouseRegion(
      onEnter: (_) {
        setState(() => hoveredIndex = index);
        _hoverController.forward(from: 0);
      },
      onExit: (_) {
        setState(() => hoveredIndex = -1);
        if (_textHoverIndex == -1) {
          _hoverController.reverse(from: _hoverController.value);
        }
      },
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          final t = isActive ? Curves.easeOutBack.transform(_hoverController.value) : 0.0;
          final extraTilt = t * 0.12; // ~7 deg
          final extraY = t * -24; // bập một nhịp xuống
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()
              ..translate(0.0, isActive ? offsetY + extraY : offsetY)
              ..rotateZ((data.rotation * math.pi / 180) + extraTilt),
            child: child,
          );
        },
        child: Image.asset(
          data.image,
          width: 320,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  void _startTextHover(int index) {
    setState(() => _textHoverIndex = index);
    _hoverController.forward(from: 0);
  }

  void _endTextHover(int index) {
    if (_textHoverIndex == index) {
      setState(() => _textHoverIndex = -1);
      if (hoveredIndex == -1) {
        _hoverController.reverse(from: _hoverController.value);
      }
    }
  }
}

class _CardData {
  final String image;
  final double rotation;
  const _CardData({required this.image, required this.rotation});
}

class _GlowBackground extends StatelessWidget {
  const _GlowBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 2.0,
            heightFactor: 1.0,
            child: Opacity(
              opacity: 0.85,
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

class _PhoneMockup extends StatelessWidget {
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;
  const _PhoneMockup({required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 640,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _PhoneFrame(),
          _PhoneScreenHolder(
            onHoverStart: onHoverStart,
            onHoverEnd: onHoverEnd,
          ),
        ],
      ),
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
  final void Function(int index) onHoverStart;
  final void Function(int index) onHoverEnd;
  const _PhoneScreenHolder({required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: 13,
      right: 13,
      top: 32,
      bottom: 26,
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
  final List<_SignalRowData> rows = const [
    _SignalRowData(icon: Icons.water_drop, pair: 'WTI', side: 'Buy limit'),
    _SignalRowData(icon: Icons.currency_bitcoin, pair: 'XAU/USD', side: 'Sell limit'),
    _SignalRowData(icon: Icons.currency_exchange, pair: 'DXY/USDT', side: 'Buy limit'),
    _SignalRowData(icon: Icons.account_balance, pair: 'XAU/USD', side: 'Sell limit'),
    _SignalRowData(icon: Icons.euro, pair: 'EUR/USD', side: 'Buy limit'),
    _SignalRowData(icon: Icons.currency_bitcoin, pair: 'BTC/USDT', side: 'Sell limit'),
  ];

  const _PhoneScreen({required this.onHoverStart, required this.onHoverEnd});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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

class SmartToolsSection extends StatelessWidget {
  const SmartToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Column(
        children: [
          Text(
            'Smarter Tools - Better Investments',
            style: AppTextStyles.h1.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Discover the features that help you minimize risks, seize opportunities, and grow your wealth.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
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
                        'Performance Overview',
                        style: AppTextStyles.h3.copyWith(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Our multi-market AI scans Forex, Crypto, and Metals in real-time, delivering expert-validated trading signals - with clear entry, stop-loss, and take-profit levels.',
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: const [
                          _StatCard(
                            title: 'Total Profit',
                            value: '9,250.8 pips',
                          ),
                          SizedBox(width: 16),
                          _StatCard(
                            title: 'Completion signal',
                            value: '507',
                          ),
                          SizedBox(width: 16),
                          _StatCard(
                            title: 'Win Rate',
                            value: '62.7%',
                          ),
                        ],
                      ),
                    ],
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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF00BFFF), Color(0xFF7B61FF), Color(0xFFD500F9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
              Text(title, style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Text(
                value,
                style: AppTextStyles.h1.copyWith(fontSize: 26, fontWeight: FontWeight.w700, color: const Color(0xFF00BFFF)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class YourOnDemandSection extends StatelessWidget {
  const YourOnDemandSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 96),
        Column(
          children: [
            Text(
              'Your On-Demand Financial Expert',
              style: AppTextStyles.h1.copyWith(fontSize: 26, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'AI platform suggests trading signals - self-learning, analyses the market 24/7, unaffected by emotions. Minvest has supported over 10,000 financial analysts\nin their journey to find accurate, stable, and easy-to-apply signals.',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 150),
        const _LaptopShowcase(),
      ],
    );
  }
}

class _LaptopShowcase extends StatelessWidget {
  const _LaptopShowcase();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 640,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: const [
          _LaptopGlow(),
          _LaptopImage(),
          _LaptopCards(),
        ],
      ),
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
  const _LaptopImage();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -30,
      child: SizedBox(
        width: 1100,
        child: Image.asset(
          'assets/mockups/laptop.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _LaptopCards extends StatelessWidget {
  const _LaptopCards();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160,
      child: Column(
        children: [
          Row(
            children: const [
              _AnimatedInfoCard(text: 'AI-Powered Trading Signal Platform', slideFromLeft: true),
              SizedBox(width: 16),
              _AnimatedInfoCard(text: 'Self-Learning Systems, Sharper Insights, Stronger Trades', slideFromLeft: false),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              _AnimatedInfoCard(text: 'Emotionless Execution For Smarter,\nMore Disciplined Trading', slideFromLeft: true),
              SizedBox(width: 16),
              _AnimatedInfoCard(text: 'Analysing the market 24/7', slideFromLeft: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedInfoCard extends StatefulWidget {
  final String text;
  final bool slideFromLeft;
  const _AnimatedInfoCard({required this.text, required this.slideFromLeft});

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
                width: 520,
                height: 118,
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
                  style: AppTextStyles.body.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
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
            'Maximize your results with Minvest AI\nadvanced market analysis and precision-filtered signals',
            style: AppTextStyles.h1.copyWith(fontSize: 30, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Minvest AI registration is now open — spots may close soon as we review and approve new members.',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, fontSize: 16),
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
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF00BFFF), Color(0xFF2E60FF), Color(0xFFD500F9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Get Signals now',
              style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
