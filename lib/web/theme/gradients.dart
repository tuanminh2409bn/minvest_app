import 'package:flutter/material.dart';
import 'colors.dart';

class AppGradients {
  // Gradient 3 màu: #04B3E9, #2E60FF, #D500F9
  static const LinearGradient cta = LinearGradient(
    colors: [
      Color(0xFF04B3E9),
      Color(0xFF2E60FF),
      Color(0xFFD500F9),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient card = LinearGradient(
    colors: [Color(0xFF0E121C), Color(0xFF0B0D14)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glow = LinearGradient(
    colors: [Color(0xFF3F5EFB), Color(0xFFFF5F6D)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
