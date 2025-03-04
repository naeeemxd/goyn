import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:goyn/customwidgets.dart/countryCodeDropDown.dart';
import 'package:goyn/provider/Login_Provider.dart';
import 'package:goyn/customwidgets.dart/country_codes.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/otp_verification_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Generate a random 6-digit OTP
  String _generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Check if user exists in Firebase
  Future<bool> _checkUserExists(String phoneNumber) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(phoneNumber)
              .get();

      return userDoc.exists;
    } catch (e) {
      print("Error checking user: $e");
      return false;
    }
  }

  // Send OTP via API
  Future<bool> _sendOTP(String mobileNumber, String otp) async {
    try {
      String template =
          "OTP+for+your+mobile+number+verification+is+$otp.Spinecodes";

      final uri = Uri.parse(
        'https://m1.sarv.com/api/v2.0/sms_campaign.php'
        '?token=140634824266559c35cb5aa4.81948085'
        '&user_id=76595417'
        '&route=TR'
        '&template_id=13908'
        '&sender_id=SPINEO'
        '&language=EN'
        '&template=$template'
        '&contact_numbers=$mobileNumber',
      );

      final response = await http.get(uri);

      // Check if the API request was successful
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }

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
                        height: 59,
                        width: width * 0.28,
                        child: CountryCodeDropdown(countryCodes: countryCodes),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: CustomTextField(
                          height: 60,
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
                        onTap: () async {
                          final selectedCountryCode =
                              provider.selectedCountryCode;
                          final mobileNumber =
                              mobileNumberController.text.trim();
                          final fullPhoneNumber =
                              "$selectedCountryCode$mobileNumber";

                          if (mobileNumber.isEmpty) {
                            // Show error for empty mobile number
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please enter a valid mobile number",
                                ),
                              ),
                            );
                            return;
                          }

                          // Show loading indicator
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(child: CircularProgressIndicator());
                            },
                          );

                          // Check if user exists in Firebase
                          bool userExists = await _checkUserExists(
                            fullPhoneNumber,
                          );

                          if (!userExists) {
                            // Close loading dialog
                            Navigator.pop(context);

                            // Show error message for unregistered user
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "This number is not registered. Please contact support.",
                                ),
                              ),
                            );
                            return;
                          }

                          // Generate OTP
                          String otp = _generateOTP();

                          // Send OTP via API
                          bool otpSent = await _sendOTP(fullPhoneNumber, otp);

                          // Close loading dialog
                          Navigator.pop(context);

                          if (otpSent) {
                            // Navigate to OTP verification screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => OtpVerificationScreen(
                                      otp: otp,
                                      phoneNumber: fullPhoneNumber,
                                    ),
                              ),
                            );
                          } else {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Failed to send OTP. Please try again.",
                                ),
                              ),
                            );
                          }
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
