import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/customwidgets.dart/color.dart';
import 'package:goyn/customwidgets.dart/custom_button.dart';
import 'package:goyn/customwidgets.dart/custom_textfield.dart';

class DriverRegistrationScreen extends StatelessWidget {
  const DriverRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppBar(
            backgroundColor: const Color(0x08000000),
            surfaceTintColor: Colors.transparent,
            elevation: 1,
            title: const Text(
              'Driver Registration',
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.025),
        child: ListView(
          children: [
            SizedBox(height: height * 0.015),
            Padding(
              padding: EdgeInsets.only(left: 7),
              child: Text(
                'Driver requirement',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ListView.builder(
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomTextField(
                      label: ['Name', 'Mobile number', 'Address'][index],
                      controller: TextEditingController(),
                    ),
                  ),
            ),
            Container(
              height: 50,
              width: width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: textFieldclr,
              ),
              child: Row(
                children: [
                  Text("Select Union", textAlign: TextAlign.start),
                  Spacer(),
                  DropdownButton<String>(
                    items: const [
                      DropdownMenuItem(child: Text('Yes'), value: 'Yes'),
                      DropdownMenuItem(child: Text('No'), value: 'No'),
                    ],
                    onChanged: (String? newValue) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              itemCount: 9,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return index != 4
                    ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: width,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: textFieldclr,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.8,
                                child: Text(
                                  [
                                    "Bank passbook/Cheque",
                                    "Police clearance certificate/Judgement copy",
                                    "Aadhaar card",
                                    "Pan card",
                                    '',
                                    "Registration Certificate",
                                    "Vehicle Insurance",
                                    "Certificate of fitness",
                                    "Vehicle permit",
                                  ][index],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                "assets/icons/RightArrow.dart.svg",
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.04,
                        bottom: height * 0.01,
                      ),
                      child: Text(
                        'Vehicle requirement',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: height * 0.15,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: Column(
          children: [CustomButton(title: 'Register', onTap: () {})],
        ),
      ),
    );
  }
}
