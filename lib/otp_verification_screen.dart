import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/customwidgets.dart/otp_textfield.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String otp;
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.otp,
    required this.phoneNumber,
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  int _secondsRemaining = 60;
  late Timer _timer;
  bool _canResend = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    final minutes = (_secondsRemaining / 60).floor();
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> resendOTP() async {
    if (!_canResend) return;

    setState(() {
      isLoading = true;
    });

    // Here you would typically call your API to resend the OTP
    // For this example, we'll just restart the timer and assume OTP was sent

    setState(() {
      isLoading = false;
    });

    startTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP has been resent to your phone number")),
    );
  }

  // Save user to Firebase
  Future<void> saveUserToFirebase(String phoneNumber) async {
    try {
      // Check if user already exists
      final userDoc =
          await _firestore.collection('users').doc(phoneNumber).get();

      if (userDoc.exists) {
        // User exists, update last login timestamp
        await _firestore.collection('users').doc(phoneNumber).update({
          'lastLogin': FieldValue.serverTimestamp(),
          'loginCount': FieldValue.increment(1),
        });
      } else {
        // User doesn't exist, create new user document
        await _firestore.collection('users').doc(phoneNumber).set({
          'phoneNumber': phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'loginCount': 1,
          'isActive': true,
        });
      }

      return;
    } catch (e) {
      print('Error saving user to Firebase: $e');
      throw e;
    }
  }

  void verifyOtp() async {
    String enteredOtp = otpController.text.trim();

    if (enteredOtp.isEmpty || enteredOtp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Verify that the entered OTP matches the one that was sent
      if (enteredOtp == widget.otp) {
        // OTP verification successful

        // Save user to Firebase
        await saveUserToFirebase(widget.phoneNumber);

        // Store the user's authentication status
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('phoneNumber', widget.phoneNumber);

        if (mounted) {
          // Navigate to home screen
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        // OTP verification failed
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Incorrect OTP. Please enter the correct code."),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                      controller: otpController,
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
                          onTap: _canResend ? resendOTP : null,
                          child: Text(
                            _canResend
                                ? " Resend OTP"
                                : " Resend in $timerText",
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
                      title: isLoading ? "Verifying..." : "Verify",
                      onTap: isLoading ? () {} : verifyOtp,
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
