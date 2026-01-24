import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle get h1 => GoogleFonts.beVietnamPro(
        fontSize: 36,
        fontWeight: FontWeight.w700, // Changed from w700 to w500
        color: AppColors.textPrimary,
      );

  static TextStyle get h2 => GoogleFonts.beVietnamPro(
        fontSize: 26,
        fontWeight: FontWeight.w600, // Changed from w700 to w500
        color: AppColors.textPrimary,
      );

  static TextStyle get h3 => GoogleFonts.beVietnamPro(
        fontSize: 22,
        fontWeight: FontWeight.w500, // Changed from w600 to w400
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.beVietnamPro(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.5,
      );

  static TextStyle get caption => GoogleFonts.beVietnamPro(
        fontSize: 8,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );
}