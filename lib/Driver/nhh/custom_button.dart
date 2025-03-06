import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/nhh/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color? color;
  final Color? borderColor;
  final Color? titleColor;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width = double.infinity,
    this.height = 50,
    this.color = yellow701,
    this.borderColor = Colors.transparent,
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: color, border: Border.all(color: borderColor!)),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: titleColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
