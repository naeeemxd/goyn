import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/customwidgets.dart/otp_textfield.dart';
import 'package:goyn/provider/otp_provider.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String otp;
  final String phoneNumber;

  const OtpVerificationScreen({
    Key? key,
    required this.otp,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => OtpVerificationProvider(otp: otp, phoneNumber: phoneNumber),
      child: const OtpVerificationView(),
      // dispose: (_, provider) => provider.dispose(),
    );
  }
}

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = Provider.of<OtpVerificationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "OTP Verification"),
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
                      "Enter the 6-digit verification code sent to your phone number",
                      style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.04),
                    OTPTextField(
                      length: 6,
                      width: width,
                      controller: provider.otpController,
                      onCompleted: (pin) {
                        provider.verifyOtp(context);
                      },
                    ),
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
                        GestureDetector(
                          onTap:
                              provider.canResend
                                  ? () => provider.resendOTP(context)
                                  : null,
                          child: Text(
                            provider.canResend
                                ? " Resend OTP"
                                : " Resend in ${provider.timerText}",
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              color: Color(0xFFF0AC00),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    CustomButton(
                      title: provider.isLoading ? "Verifying..." : "Verify",
                      onTap:
                          provider.isLoading
                              ? () {}
                              : () => provider.verifyOtp(context),
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
