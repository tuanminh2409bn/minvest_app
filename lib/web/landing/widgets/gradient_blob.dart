import 'package:flutter/material.dart';
import '../../theme/gradients.dart';

class GradientBlob extends StatelessWidget {
  final double size;
  const GradientBlob({super.key, this.size = 320});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.cta,
        ),
      ),
    );
  }
}
