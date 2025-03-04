import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/widgetProfile.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';
import 'package:goyn/customwidgets.dart/color.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/provider/ImageProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDrivers extends StatelessWidget {
  AddDrivers({super.key});

  // ValueNotifiers for storing form data
  final ValueNotifier<String?> selectedUnion = ValueNotifier<String?>(null);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Document upload status trackers
  final Map<String, bool> documentStatus = {
    "Bank passbook/Cheque": false,
    "Police clearance certificate/Judgement copy": false,
    "Aadhaar card": false,
    "Pan card": false,
    "Registration Certificate": false,
    "Vehicle Insurance": false,
    "Certificate of fitness": false,
    "Vehicle permit": false,
  };

  // Function to check if mobile number already exists in any union
  Future<bool> isMobileNumberRegistered(String mobileNumber) async {
    final firestore = FirebaseFirestore.instance;

    // Get all unions
    final unionsSnapshot = await firestore.collection('unions').get();

    // Check each union's drivers collection for the mobile number
    for (var unionDoc in unionsSnapshot.docs) {
      final driversQuery =
          await firestore
              .collection('unions')
              .doc(unionDoc.id)
              .collection('drivers')
              .where('mobile', isEqualTo: mobileNumber)
              .limit(1)
              .get();

      // If we found a match, return true
      if (driversQuery.docs.isNotEmpty) {
        return true;
      }
    }

    // No matches found
    return false;
  }

  // Function to save driver data to Firebase
  Future<void> saveDriverData(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final unionName = selectedUnion.value;
      final mobileNumber = mobileController.text.trim();

      // Validate required fields
      if (nameController.text.isEmpty ||
          mobileNumber.isEmpty ||
          addressController.text.isEmpty) {
        Navigator.pop(context); // Remove loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
        return;
      }

      if (unionName == null || unionName.isEmpty) {
        Navigator.pop(context); // Remove loading dialog
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a union')));
        return;
      }

      // Check if mobile number is already registered
      final isRegistered = await isMobileNumberRegistered(mobileNumber);
      if (isRegistered) {
        Navigator.pop(context); // Remove loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'This mobile number is already registered with a driver',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Get a reference to Firestore
      final firestore = FirebaseFirestore.instance;

      // Create driver data map
      final driverData = {
        'name': nameController.text,
        'mobile': mobileNumber,
        'address': addressController.text,
        'union': unionName,
        'documentStatus': documentStatus,
        'registrationDate': FieldValue.serverTimestamp(),
      };

      // Add document to 'drivers' subcollection under the selected union
      await firestore
          .collection('unions')
          .doc(unionName)
          .collection('drivers')
          .add(driverData);

      // Remove loading dialog
      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Driver registered successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Clear the form fields
      nameController.clear();
      mobileController.clear();
      addressController.clear();
      selectedUnion.value = null;
    } catch (e) {
      // Remove loading dialog
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error registering driver: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // List of controllers for each text field
    final List<TextEditingController> controllers = [
      nameController,
      mobileController,
      addressController,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Add Drivers"),
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

            // Driver personal details
            ListView.builder(
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomTextField(
                      label: ['Name', 'Mobile number', 'Address'][index],
                      controller: controllers[index],
                    ),
                  ),
            ),
            const SizedBox(height: 10),

            // Union selection widget
            Consumer<UnionProvider>(
              builder: (context, unionProvider, child) {
                final unions = unionProvider.unions;

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Select Union",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: unions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(unions[index].unionName),
                                      onTap: () {
                                        selectedUnion.value =
                                            unions[index].unionName;
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    width: width,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: textFieldclr,
                    ),
                    child: ValueListenableBuilder<String?>(
                      valueListenable: selectedUnion,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value ?? "Select Union",
                              style: TextStyle(
                                color:
                                    value == null
                                        ? Colors.grey.shade600
                                        : Colors.black,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Document sections
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
                        documentName: "Police clearance/Judgement Certificate",
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
                              ValueListenableBuilder<bool>(
                                valueListenable: ValueNotifier<bool>(
                                  documentStatus[selectedItem] ?? false,
                                ),
                                builder: (context, isUploaded, _) {
                                  return isUploaded
                                      ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                      : SvgPicture.asset(
                                        "assets/icons/RightArrow.svg",
                                      );
                                },
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
        onButtonTap: () => saveDriverData(context),
        buttonTitle: 'Register',
      ),
    );
  }
}