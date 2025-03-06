import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/nhh/app_colors.dart';

class AppTextStyles {
  static TextStyle baseStyle({
    double fontSize = 14,
    Color color = black423,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.openSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
