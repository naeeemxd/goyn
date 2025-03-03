import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/Driver_Edit.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final double height;
  // Added height parameter

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.height = 52, // Default height value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // Use the height parameter
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.grey[600],
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onButtonTap;
  final Color backgroundColor;
  final double height;
  final double horizontalPadding;
  final double verticalPadding;

  const CustomBottomAppBar({
    super.key,
    required this.buttonTitle,
    required this.onButtonTap,
    this.backgroundColor = Colors.white,
    this.height = 0.1, // Relative to screen height
    this.horizontalPadding = 0.04, // Relative to screen width
    this.verticalPadding = 0.01, // Relative to screen height
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return BottomAppBar(
      color: backgroundColor,
      height: screenHeight * height,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * horizontalPadding,
        vertical: screenHeight * verticalPadding,
      ),
      child: Column(
        children: [CustomButton(title: buttonTitle, onTap: onButtonTap)],
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Driver?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to delete this driver? This action cannot be undone',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFFEA0004),
                      elevation: 0,
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Delete',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFEA0004),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0AC00),
                      borderRadius: BorderRadius.circular(
                        24,
                      ), // Match button shape
                    ),
                    child: CustomButton(
                      title: 'Edit',
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DriverEditScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmationDialog();
    },
  );
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;

  const CustomAppBar({Key? key, required this.title, this.onBackPress})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: AppBar(
          backgroundColor: const Color(0x08000000),
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
            onPressed: onBackPress ?? () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;
  final Color borderColor;
  final Color titleColor;
  final BorderRadius borderRadius;

  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width = double.infinity,
    this.height = 50,
    this.color = const Color(0xFFF0AC00),
    this.borderColor = Colors.transparent,
    this.titleColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.openSans(
              fontSize: 16,
              color: titleColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
