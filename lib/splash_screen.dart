import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:goyn/Union/Union_List.dart';
import 'package:goyn/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Check authentication status and navigate
    _checkAuthAndNavigate(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/splash_logo.png', scale: 4),
      ),
    );
  }

  Future<void> _checkAuthAndNavigate(BuildContext context) async {
    try {
      // Delay for splash screen display
      await Future.delayed(const Duration(seconds: 2));

      // Get authentication status from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      // Navigate to the appropriate screen
      if (isLoggedIn) {
        // User is logged in, go to home screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => GoynHomePageContent()),
          (route) => false,
        );
      } else {
        // User is not logged in, go to login screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      print('Error in splash screen: $e');
      // If there's an error, default to login screen
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      //   (route) => false,
      // );
    }
  }
}
