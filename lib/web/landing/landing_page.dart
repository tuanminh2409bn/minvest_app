import 'package:flutter/material.dart';
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

class _HeroInteractiveState extends State<_HeroInteractive> {
  Offset _pointer = Offset.zero;

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
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Guiding Traders & Growing Portfolios',
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(fontSize: 44),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'The Ultimate AI Engine – Designed by Expert Traders.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
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
                    onPressed: () {},
                  ),
                  const SizedBox(width: AppSpacing.md),
                  GradientButton(
                    label: 'Free Trial',
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
                    onPressed: () {},
                  ),
                ],
              ),
            ],
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

class HeroSignalsSection extends StatelessWidget {
  const HeroSignalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.clamp(320.0, 560.0);
        return Center(
          child: Container(
            width: maxWidth,
            padding: const EdgeInsets.all(2),
            constraints: const BoxConstraints(minHeight: 480),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF04B3E9), Color(0xFFD500F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: AppSpacing.md),
                  _buildTabs(),
                  const SizedBox(height: AppSpacing.md),
                  const _SignalCard(
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
                  const SizedBox(height: AppSpacing.sm),
                  const _SignalCard(
                    icon: Icons.auto_awesome,
                    iconColor: Color(0xFF00B6FF),
                    pair: 'XAUUSD',
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
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

  Widget _buildTabs() {
    Widget tab(String text, {bool active = false}) {
      return Container(
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

class LiveSignalsSection extends StatelessWidget {
  const LiveSignalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxl),
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
            _chip('AI Signals'),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'LIVE – 24/7 AI Trading Signals',
              style: AppTextStyles.h1.copyWith(fontSize: 42, fontWeight: FontWeight.w800),
            ),
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
    );
  }

  Widget _chip(String text) {
    return Container(
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

class OrderEngineSection extends StatelessWidget {
  const OrderEngineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 520),
                child: const _OrderCard(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 520),
              child: const _KeyFindingsCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard();

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
          _chip(),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Order Explanation Engine',
            style: AppTextStyles.h1.copyWith(fontSize: 40, fontWeight: FontWeight.w800),
          ),
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

  Widget _chip() {
    return Container(
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

class _KeyFindingsCard extends StatelessWidget {
  const _KeyFindingsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF04B3E9), Color(0xFFD500F9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
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
            _chartPlaceholder(),
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
  }

  Widget _chartPlaceholder() {
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
          painter: _ChartPainter(),
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
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = const Color(0xFF00C6FF)
      ..strokeWidth = 3
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

    final points = [
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

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

class _SignalsPerformanceCard extends StatelessWidget {
  const _SignalsPerformanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF04B3E9), Color(0xFFD500F9)],
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
            _item(Icons.balance, 'Risk-to-Reward Ratio', 'How risk compares to reward'),
            _item(Icons.attach_money, 'Profit/Loss Overview', 'Net gain vs loss'),
            _item(Icons.emoji_events, 'Win Rate', 'Percentage of winning trades'),
            _item(Icons.track_changes, 'Accuracy Rate', 'How precise our signals are'),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF0D101A), Color(0xFF0A0B13)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
    );
  }
}

class _TransparentCard extends StatelessWidget {
  const _TransparentCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _chip(),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Transparent - Real Performance',
              style: AppTextStyles.h1.copyWith(fontSize: 40, fontWeight: FontWeight.w800),
            ),
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
                _pill('Results'),
                _pill('Performance-Tracking'),
                _pill('Accurate'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip() {
    return Container(
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
            'Our AI monitors the market continuously, identifying technical convergence zones and reliable breakout points – so you can enter trades at the right moment.'
      ),
      (
        title: 'Save Time on Analysis',
        desc:
            'No more hours spent reading charts. Receive tailored investment strategies in just minutes a day.'
      ),
      (
        title: 'Minimize Emotional Trading',
        desc:
            'With smart alerts, risk detection, and data-driven signals – not emotions – you stay disciplined and in control of every decision.'
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
            children: items
                .map(
                  (item) => _CoreValueCard(
                    title: item.title,
                    description: item.desc,
                  ),
                )
                .toList(),
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
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4779D4),
            Color(0xFF3E42BD),
            Color(0xFFC812E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
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
          Text(
            answer.isEmpty ? 'Content updating...' : answer,
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 13),
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
                GradientButton(label: 'Get Signals Now', onPressed: () {}),
                const SizedBox(width: AppSpacing.md),
                TextButton(
                  onPressed: () {},
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
