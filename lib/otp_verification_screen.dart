import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Union_List.dart';
import 'package:goyn/customwidgets.dart/CustomAppBar.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';
import 'package:goyn/customwidgets.dart/otp_textfield.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Otp Verification"),
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              SizedBox(
                height:
                    (MediaQuery.of(context).size.height / 2) -
                    (MediaQuery.of(context).viewInsets.bottom / 1),
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
                        Text(
                          " resend in 00:05",
                          style: GoogleFonts.openSans(
                            fontSize: 12,
                            color: Color(0xFFF0AC00),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    CustomButton(
                      title: "Verify",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoynHomePageContent(),
                          ),
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
      ),
    );
  }
}
