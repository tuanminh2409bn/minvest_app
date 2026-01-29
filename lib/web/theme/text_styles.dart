import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Figma: Hero Title - 64px, w700, -3.2 spacing
  static TextStyle get heroTitle => GoogleFonts.beVietnamPro(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -3.2,
        height: 1.1,
      );

  // Figma: Section Title / Hero Subtitle - 36px/40px, w700, -1.8/-2.0 spacing
  // Dùng chung cho các tiêu đề lớn của section
  static TextStyle get sectionTitle => GoogleFonts.beVietnamPro(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -2.0,
      );

  static TextStyle get h1 => heroTitle; // Alias cũ

  static TextStyle get h2 => GoogleFonts.beVietnamPro(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.8,
      );

  // Figma: Sub-headlines (Real-Time Market Analysis...) - 26px, w600, -1.3 spacing
  static TextStyle get h3 => GoogleFonts.beVietnamPro(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -1.3,
      );

  // Figma: Body Intro (Guiding Traders...) - 22px, w400, -1.10 spacing
  static TextStyle get bodyLarge => GoogleFonts.beVietnamPro(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: -1.1,
      );

  // Figma: Standard Body / Buttons / Card Text - 18px, w400/w600, -0.9 spacing
  static TextStyle get body => GoogleFonts.beVietnamPro(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary, // Mặc định secondary, có thể override
        letterSpacing: -0.9,
      );
  
  static TextStyle get bodyBold => GoogleFonts.beVietnamPro(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.9,
      );

  static TextStyle get caption => GoogleFonts.beVietnamPro(
        fontSize: 14, // Figma dùng 14 cho các text nhỏ như "Monthly"
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: -0.7,
      );
}
