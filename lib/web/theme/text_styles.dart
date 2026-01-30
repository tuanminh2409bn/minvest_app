import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Figma: Hero Title - 64px, w700, -3% spacing (-1.92)
  static TextStyle get heroTitle => GoogleFonts.beVietnamPro(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.92,
        height: 1.1,
      );

  // Figma: Section Title / Hero Subtitle - 40px, w700, -3% spacing (-1.2)
  static TextStyle get sectionTitle => GoogleFonts.beVietnamPro(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.2,
      );

  static TextStyle get h1 => heroTitle; // Alias cũ

  static TextStyle get h2 => GoogleFonts.beVietnamPro(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1.08,
      );

  // Figma: Sub-headlines - 26px, w600, -3% spacing (-0.78)
  static TextStyle get h3 => GoogleFonts.beVietnamPro(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.78,
      );

  // Figma: Body Intro - 22px, w400, -3% spacing (-0.66)
  static TextStyle get bodyLarge => GoogleFonts.beVietnamPro(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: -0.66,
      );

  // Figma: Standard Body / Buttons / Card Text - 18px, w400/w600, -3% spacing (-0.54)
  static TextStyle get body => GoogleFonts.beVietnamPro(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary, // Mặc định secondary, có thể override
        letterSpacing: -0.54,
      );
  
  static TextStyle get bodyBold => GoogleFonts.beVietnamPro(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.54,
      );

  static TextStyle get caption => GoogleFonts.beVietnamPro(
        fontSize: 14, // Figma dùng 14 cho các text nhỏ như "Monthly"
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: -0.42,
      );
}
