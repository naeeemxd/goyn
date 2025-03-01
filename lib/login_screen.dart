import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/countryCodeDropDown.dart';
import 'package:goyn/provider/Login_Provider.dart';
import 'package:provider/provider.dart';
import 'package:goyn/customwidgets.dart/country_codes.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';
import 'package:goyn/customwidgets.dart/custom_textfield.dart';
import 'package:goyn/otp_verification_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final TextEditingController mobileNumberController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Image.asset('assets/images/splash_logo.png', scale: 4),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.035),
                  Row(
                    children: [
                      SizedBox(
                        height: 49,
                        width: width * 0.28,
                        child: CountryCodeDropdown(countryCodes: countryCodes),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: CustomTextField(
                          label: "Mobile number",
                          keyboardType: TextInputType.phone,
                          controller: mobileNumberController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.04),
                  Consumer<CountryCodeProvider>(
                    builder: (context, provider, child) {
                      return CustomButton(
                        title: "Send OTP",
                        onTap: () {
                          // You can access selected country code via provider
                          final selectedCountryCode =
                              provider.selectedCountryCode;
                          final mobileNumber = mobileNumberController.text;

                          // You can log or use the values if needed
                          print('Country Code: $selectedCountryCode');
                          print('Mobile Number: $mobileNumber');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVerificationScreen(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: height * 0.08),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
