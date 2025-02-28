import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';
import 'package:goyn/customwidgets.dart/custom_textfield.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: UnionRegistration()));
}

TextEditingController unionController = TextEditingController();
TextEditingController registrationController = TextEditingController();

class UnionRegistration extends StatelessWidget {
  const UnionRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppBar(
            backgroundColor: const Color(0x08000000),
            surfaceTintColor: Colors.transparent,
            elevation: 1,
            title: const Text(
              'Union Registration',
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
              onPressed: () {
                Navigator.pop(context); 
              },
            ),
          ),
        ),
      ),
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
