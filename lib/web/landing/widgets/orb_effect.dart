import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class OrbEffect extends StatefulWidget {
  final Widget? child;
  const OrbEffect({super.key, this.child});

  @override
  State<OrbEffect> createState() => _OrbEffectState();
}

class _OrbEffectState extends State<OrbEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_OrbParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Initialize particles (The "Orbs")
    // We create a mix of Cyan, Blue, and Purple orbs to match the theme
    final colors = [
      const Color(0xFF04B3E9).withOpacity(0.6), // Cyan
      const Color(0xFF2E60FF).withOpacity(0.6), // Blue
      const Color(0xFFD500F9).withOpacity(0.5), // Purple
      const Color(0xFF00C6FF).withOpacity(0.4), // Light Blue
    ];

    for (int i = 0; i < 5; i++) {
      _particles.add(_OrbParticle(
        color: colors[i % colors.length],
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        speedX: (_random.nextDouble() - 0.5) * 0.3, // Slow movement
        speedY: (_random.nextDouble() - 0.5) * 0.3,
        radius: 0.3 + _random.nextDouble() * 0.4, // Large relative radius (30% to 70% of screen)
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The Background & Orbs
        Positioned.fill(
          child: Container(
            color: Colors.black, // Deep background
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _OrbPainter(
                    particles: _particles,
                    progress: _controller.value,
                  ),
                );
              },
            ),
          ),
        ),
        
        // Blur Filter to merge the orbs into a "fluid" look
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),

        // Content on top (if any)
        if (widget.child != null)
          Positioned.fill(child: widget.child!),
      ],
    );
  }
}

class _OrbParticle {
  double x;
  double y;
  double speedX;
  double speedY;
  double radius;
  Color color;

  _OrbParticle({
    required this.x,
    required this.y,
    required this.speedX,
    required this.speedY,
    required this.radius,
    required this.color,
  });
}

class _OrbPainter extends CustomPainter {
  final List<_OrbParticle> particles;
  final double progress;

  _OrbPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // We use Screen blending to make colors pop when they overlap
    final paint = Paint()..blendMode = BlendMode.screen;

    for (var particle in particles) {
      // Calculate animated position
      // Using sine/cosine to create organic floating movement instead of linear
      final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
      
      // Add some "wobble" to the movement
      final dx = particle.x + sin(time * particle.speedX) * 0.2;
      final dy = particle.y + cos(time * particle.speedY) * 0.2;

      // Wrap around screen roughly
      final posX = (dx % 1.4 - 0.2) * size.width; // Allow moving slightly offscreen
      final posY = (dy % 1.4 - 0.2) * size.height;
      
      final radius = particle.radius * min(size.width, size.height);

      // Create a radial gradient for soft edges
      final gradient = RadialGradient(
        colors: [
          particle.color,
          particle.color.withOpacity(0.0),
        ],
        stops: const [0.2, 1.0],
      );

      paint.shader = gradient.createShader(
        Rect.fromCircle(center: Offset(posX, posY), radius: radius),
      );

      canvas.drawCircle(Offset(posX, posY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) => true;
}
