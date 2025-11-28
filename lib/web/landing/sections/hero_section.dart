import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/spacing.dart';
import '../widgets/gradient_button.dart';
import '../widgets/badge.dart';
import '../../theme/content.dart';

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
