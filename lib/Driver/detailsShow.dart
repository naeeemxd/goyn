import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';

class DocumentPage extends StatelessWidget {
  final String title;
  final String? imagePlaceholderText;
  final bool showTextField; // New parameter to control text field visibility

  const DocumentPage({
    Key? key,
    required this.title,
    this.imagePlaceholderText,
    this.showTextField = true, // Default is true (text field is shown)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final String iimagePlaceholderText = imagePlaceholderText ?? title;

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the card image
            Container(
              width: double.infinity,
              height: height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200], // Placeholder background color
              ),
              child: Center(
                child: Text(
                  iimagePlaceholderText,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            if (showTextField) ...[
              // Conditionally show the text field
              Text(
                " $title number",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  '',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            const Spacer(),
            // Save button at the bottom
            CustomButton(title: 'Save', onTap: () {}, color: Color(0xFFFFF3E0)),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
