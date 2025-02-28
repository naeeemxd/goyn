import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Union_List.dart';
import 'package:goyn/customwidgets.dart/color.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';
import 'package:goyn/customwidgets.dart/otp_textfield.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.57,
              width: width,
              child: Center(
                child: Image.asset('assets/images/splash_logo.png', scale: 4),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "OTP Verification",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    "Enter 6 digit verification code sent to your phone number",
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.04),
                  OTPTextField(length: 6, width: width),
                  SizedBox(height: height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive?",
                        style: GoogleFonts.openSans(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 3),
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Row(
                          children: [
                            Text(
                              "resend in ",
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "00:05",
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.04),
                  CustomButton(
                    title: "Verify ",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoynHomePage()),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
