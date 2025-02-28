import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPTextField extends StatefulWidget {
  final double width;
  final int length;

  const OTPTextField({
    super.key,
    required this.length,
    required this.width,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: widget.length,
      controller: _otpController,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: widget.width * 0.125,
        height: 45,
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: widget.width * 0.125,
        height: 45,
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
      ),
      onChanged: (value) {
        print("OTP Entered: $value");
      },
      onCompleted: (pin) {
        print("OTP Completed: $pin");
      },
    );
  }
}
