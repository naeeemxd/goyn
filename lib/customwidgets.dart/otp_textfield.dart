import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPTextField extends StatefulWidget {
  final double width;
  final int length;
  final Function(String)? onCompleted; // Callback for when OTP is completed
  final Function(String)? onChanged; // Callback for when OTP is changed
  final TextEditingController? controller; // Optional controller

  const OTPTextField({
    super.key,
    required this.length,
    required this.width,
    this.onCompleted,
    this.onChanged,
    this.controller,
  });

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late TextEditingController _otpController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one
    _otpController = widget.controller ?? TextEditingController();
  }

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
        if (widget.onChanged != null) {
          widget.onChanged!(value); // Notify parent widget of OTP change
        }
      },
      onCompleted: (pin) {
        if (widget.onCompleted != null) {
          widget.onCompleted!(pin); // Notify parent widget of OTP completion
        }
      },
    );
  }
}