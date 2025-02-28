import 'package:flutter/material.dart';
import 'package:goyn/customwidgets.dart/CustomAppBar.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';
import 'package:goyn/customwidgets.dart/custom_textfield.dart';

TextEditingController unionController = TextEditingController();
TextEditingController registrationController = TextEditingController();

class UnionRegistration extends StatelessWidget {
  const UnionRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Union Registration"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(label: "Union name", controller: unionController),
            const SizedBox(height: 16), // Add spacing
            CustomTextField(
              label: "Registration number",
              controller: registrationController,
            ),
            Spacer(),
            CustomButton(
              title: "Register",
              color: Color(0xFFF0AC00),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
