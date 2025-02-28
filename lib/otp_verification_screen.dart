import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppBar(
            backgroundColor: Color(0x08000000),
            surfaceTintColor: Colors.transparent,
            elevation: 1,
            title: const Text(
              'Driver Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
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
                      ],
                    ),
                    SizedBox(height: height * 0.04),
                    CustomButton(
                      title: "Verify",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoynHomePage(),
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
