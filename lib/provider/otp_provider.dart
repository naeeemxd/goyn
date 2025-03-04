import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class OtpVerificationProvider with ChangeNotifier {
  String otp;
  final String phoneNumber;
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  int _secondsRemaining = 60;
  bool _canResend = false;
  bool _disposed = false;
  Timer? _timer;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OtpVerificationProvider({required this.otp, required this.phoneNumber}) {
    startTimer();
    otpController.addListener(_autoVerify);
  }

  bool get canResend => _canResend;

  // Automatically verify OTP when 6 digits are entered
  void _autoVerify() {
    if (_disposed) return; // ✅ Prevent executing if disposed
    if (otpController.text.length == 6 && !isLoading) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (_disposed) return; // ✅ Prevent accessing after disposal
        verifyOtp(null);
      });
    }
  }

  String get timerText {
    final minutes = (_secondsRemaining / 60).floor();
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer?.cancel(); // ✅ Cancel existing timer

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_disposed) {
        timer.cancel();
        return;
      }

      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _canResend = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  Future<void> resendOTP(BuildContext context) async {
    if (!_canResend) return;

    isLoading = true;
    notifyListeners();

    // Generate new OTP
    String newOtp = _generateOTP();
    bool otpSent = await _sendOTP(phoneNumber, newOtp);
    otp = newOtp; // ✅ Update OTP

    isLoading = false;
    notifyListeners();

    if (otpSent) {
      startTimer(); // ✅ Restart the timer
      if (!_disposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("New OTP has been sent to your phone number")),
        );
      }
    } else {
      if (!_disposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP. Please try again.")),
        );
      }
    }
  }

  // Generate a random 6-digit OTP
  String _generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
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
      return response.statusCode == 200;
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }

  // Save user to Firebase
  Future<void> saveUserToFirebase(String phoneNumber) async {
    try {
      final userDoc =
          await _firestore.collection('users').doc(phoneNumber).get();

      if (userDoc.exists) {
        await _firestore.collection('users').doc(phoneNumber).update({
          'lastLogin': FieldValue.serverTimestamp(),
          'loginCount': FieldValue.increment(1),
        });
      } else {
        await _firestore.collection('users').doc(phoneNumber).set({
          'phoneNumber': phoneNumber,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'loginCount': 1,
          'isActive': true,
        });
      }
    } catch (e) {
      print('Error saving user to Firebase: $e');
      throw e;
    }
  }

  Future<void> verifyOtp(BuildContext? context) async {
    if (_disposed) return; // ✅ Prevent running if disposed

    String enteredOtp = otpController.text.trim();
    if (enteredOtp.isEmpty || enteredOtp.length != 6) {
      if (context != null && !_disposed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid 6-digit OTP.")),
        );
      }
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      if (enteredOtp == otp) {
        await saveUserToFirebase(phoneNumber);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('phoneNumber', phoneNumber);

        if (context != null && !_disposed) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (context != null && !_disposed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Incorrect OTP. Please try again.")),
          );
        }
      }
    } catch (e) {
      if (context != null && !_disposed) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      }
    }

    isLoading = false;
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    otpController.removeListener(_autoVerify);
    otpController.dispose(); // ✅ Properly dispose the controller
    super.dispose();
  }
}
