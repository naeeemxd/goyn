import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/widgetProfile.dart';
import 'package:goyn/customwidgets.dart/color.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/provider/ImageProvider.dart';

class DriverEditScreen extends StatelessWidget {
  DriverEditScreen({super.key});

  // Simulated existing document data
  final Map<String, bool> existingDocuments = {
    "Aadhaar card": true,
    "Pan card": true,
    "Bank passbook/Cheque": false,
    "Police clearance certificate/Judgement copy": false,
    "Registration Certificate": true,
    "Vehicle Insurance": false,
    "Certificate of fitness": true,
    "Vehicle permit": false,
  };

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Edit Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.025),
        child: ListView(
          children: [
            SizedBox(height: height * 0.015),
            Padding(
              padding: const EdgeInsets.only(left: 7),
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
                  const Text("Select Union"),
                  const Spacer(),
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
                if (index == 4) {
                  return Padding(
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
                }

                final documentNames = [
                  "Bank passbook/Cheque",
                  "Police clearance certificate/Judgement copy",
                  "Aadhaar card",
                  "Pan card",
                  "",
                  "Registration Certificate",
                  "Vehicle Insurance",
                  "Certificate of fitness",
                  "Vehicle permit",
                ];

                final providers = {
                  "Bank passbook/Cheque": DriverProfileWidget<BankProvider>(
                    documentName: "Bank passbook/Cheque",
                  ),
                  "Police clearance certificate/Judgement copy":
                      DriverProfileWidget<PoliceProvider>(
                        documentName:
                            "Police clearance certificate/Judgement copy",
                      ),
                  "Aadhaar card": DriverProfileWidget<AdharProvider>(
                    documentName: "Aadhaar Card",
                  ),
                  "Pan card": DriverProfileWidget<PanProvider>(
                    documentName: "Pan Card",
                  ),
                  "Registration Certificate":
                      DriverProfileWidget<RegistrationnProvider>(
                        documentName: "Registration Certificate",
                      ),
                  "Vehicle Insurance": DriverProfileWidget<InsuranceProvider>(
                    documentName: "Vehicle Insurance",
                  ),
                  "Certificate of fitness":
                      DriverProfileWidget<FitnessProvider>(
                        documentName: "Certificate of Fitness",
                      ),
                  "Vehicle permit": DriverProfileWidget<BankProvider>(
                    documentName: "Vehicle Permit",
                  ),
                };

                String selectedItem = documentNames[index];

                return selectedItem.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (providers.containsKey(selectedItem)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => providers[selectedItem]!,
                              ),
                            );
                          }
                        },
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
                                  selectedItem,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SvgPicture.asset(
                                existingDocuments[selectedItem] == true
                                    ? "assets/icons/greenTick.svg"
                                    : "assets/icons/RightArrow.svg",
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        onButtonTap: () {},
        buttonTitle: 'Register',
      ),
    );
  }
}
