import 'package:flutter/material.dart';
import 'package:goyn/Union_List.dart';
import 'package:goyn/login_screen.dart';
import 'package:goyn/otp_verification_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/splash_logo.png', scale: 4),
      ),
    );
  }
}
