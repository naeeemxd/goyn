import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextField(
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.grey[600],
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
