import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/nhh/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool backButtonNeeded;

  const CommonAppBar({
    super.key,
    required this.title,
    this.onBack,
    required this.backButtonNeeded,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.15,
      width: width,
      color: Color(0x08000000),
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.05, right: width * 0.01, left: width * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backButtonNeeded
                ? IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.keyboard_arrow_left_outlined),
                  )
                : SizedBox(width: 0),
            SizedBox(
              width: width * 0.7,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: black423,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Empty Sized Box for Adjust the App bar
            backButtonNeeded ? SizedBox(width: width * 0.12) : SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(200);
}
