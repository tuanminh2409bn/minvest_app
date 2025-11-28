import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';
import 'package:flutter/material.dart';

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
                child: _OrderCard(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 520),
              child: _KeyFindingsCard(),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
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

    // draw grid
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
