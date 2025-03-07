import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/Driver_List.dart';
import 'package:goyn/Driver/nhh/app_colors.dart';
import 'package:goyn/Driver/nhh/app_text_style.dart';
import 'package:goyn/Driver/nhh/custom_app_bar.dart';
import 'package:goyn/Driver/nhh/driver_registration.dart';
import 'package:goyn/Driver/nhh/photo_upload_screen.dart';
import 'package:goyn/Driver/nhh/registration_provider.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:provider/provider.dart';

class DriverRegistrationScreen extends StatelessWidget {
  const DriverRegistrationScreen({super.key, this.union, this.unionDocId});
  final String? union;
  final String? unionDocId;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final registrationProvider = Provider.of<RegistrationProvider>(
      context,
      listen: false,
    );
    if (union != null) {
      registrationProvider.UnionController.text = union!;
      registrationProvider.selectedUnionName = union!;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: 'Registration', backButtonNeeded: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.025),
        child: ListView(
          children: [
            SizedBox(height: height * 0.015),
            Padding(
              padding: EdgeInsets.only(left: width * 0.04),
              child: Text(
                'Driver requirement',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: black423,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 5),
            ListView.builder(
              itemCount: 3,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CustomTextField(
                      keyboardType:
                          index == 1 ? TextInputType.phone : TextInputType.text,
                      // maxlength: index == 1 ? 10 : 500,
                      label: ['Name', 'Mobile number', 'Address'][index],
                      controller:
                          [
                            registrationProvider.driverNameController,
                            registrationProvider.driverMobileNumberController,
                            registrationProvider.driverAddressController,
                          ][index],
                    ),
                  ),
            ),
            CustomTextField(
              enabled: false,
              label: 'Union', // Fallback text if union is null
              controller: registrationProvider.UnionController,
            ),

            SizedBox(height: 20),
            ListView.builder(
              itemCount: 9,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return index != 4
                    ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => PhotoUploadScreen(
                                    title:
                                        [
                                          "Bank passbook/Cheque",
                                          "Police clearance certificate/Judgement copy",
                                          "Aadhaar card",
                                          "Pan card",
                                          "Profile Screen"
                                              '',
                                          "Registration Certificate",
                                          "vehicle Insurance",
                                          "Certificate of fitness",
                                          "Vehicle permit",
                                        ][index],
                                    detaileNumber:
                                        [0, 1, 2, 3, 0, 5, 6, 7, 8][index],
                                    completed:
                                        [
                                          registrationProvider
                                              .bankPassBookProccessCompleted,
                                          registrationProvider
                                              .policeClearenceCertificateOrJudgementCopyProcessCompleted,
                                          registrationProvider
                                              .aadhaarCardProcessCompleted,
                                          registrationProvider
                                              .panCardProcessCompleted,
                                          // Blank
                                          false,
                                          //
                                          registrationProvider
                                              .registrationCertificatedProccessCompleted,
                                          registrationProvider
                                              .vehicleInsuranceProccessCompleted,
                                          registrationProvider
                                              .certificateOfFitnessProccessCompleted,
                                          registrationProvider
                                              .vehiclePermitProccessCompleted,
                                        ][index],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: width,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: grey5F5,
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
                                    //blank
                                    '',
                                    "Registration Certificate",
                                    "vehicle Insurance",
                                    "Certificate of fitness",
                                    "Vehicle permit",
                                  ][index],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                    fontSize: 13,
                                    color: black423,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Consumer<RegistrationProvider>(
                                builder: (context, person, child) {
                                  final completedData =
                                      [
                                        person.bankPassBookProccessCompleted,
                                        person
                                            .policeClearenceCertificateOrJudgementCopyProcessCompleted,
                                        person.aadhaarCardProcessCompleted,
                                        person.panCardProcessCompleted,
                                        // Blank
                                        true,
                                        //
                                        registrationProvider
                                            .registrationCertificatedProccessCompleted,
                                        registrationProvider
                                            .vehicleInsuranceProccessCompleted,
                                        registrationProvider
                                            .certificateOfFitnessProccessCompleted,
                                        registrationProvider
                                            .vehiclePermitProccessCompleted,
                                      ][index];
                                  return CircleAvatar(
                                    radius: 9,
                                    backgroundColor:
                                        completedData ? Colors.green : black423,
                                    child: Center(
                                      child: Icon(
                                        completedData
                                            ? Icons.check
                                            : Icons.keyboard_arrow_right,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  );
                                },
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
                          color: black423,
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
        height: height * 0.10,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: Column(
          children: [
            Consumer<RegistrationProvider>(
              builder:
                  (context, person, child) => CustomButton(
                    title: 'Register',
                    color:
                        person.isRegistrationProccessCompleted()
                            ? yellow701
                            : disabledButtoncolor,
                    onTap: () {
                      if (person.isRegistrationProccessCompleted()) {
                        DBDriverRegistration()
                            .driverRequirementsSaveToFirestoreDataBase(
                              driverName:
                                  registrationProvider
                                      .driverNameController
                                      .text,
                              driverMobileNumber:
                                  registrationProvider
                                      .driverMobileNumberController
                                      .text,
                              driverAddress:
                                  registrationProvider
                                      .driverAddressController
                                      .text,
                              memberOfUnionName:
                                  registrationProvider.selectedUnionName,
                              bankPassBookOrCheckNumber:
                                  registrationProvider
                                      .bankPassBookOrCheckNumberController
                                      .text,
                              unionDocId: unionDocId ?? '',
                              policeClearanceCertificateOrJudgementCopy:
                                  registrationProvider
                                      .policeClearenceCertificateOrJudgementCopyController
                                      .text,
                              aadhaarCardNumber:
                                  registrationProvider
                                      .aadhaarCardController
                                      .text,
                              panCardNumber:
                                  registrationProvider.panCardController.text,

                              // ✅ Change `registrationCertificate` to `registrationCertificateNumber`
                              registrationCertificateNumber:
                                  registrationProvider
                                      .registrationCertificateController
                                      .text,
                              vehicleInsuranceNumber:
                                  registrationProvider
                                      .vehicleInsuranceController
                                      .text,
                              certificateOfFitnessNumber:
                                  registrationProvider
                                      .certificateOfFitnessController
                                      .text,
                              vehiclePermitNumber:
                                  registrationProvider
                                      .vehiclePermitController
                                      .text,

                              // Images
                              bankPassBookOrCheckImage:
                                  registrationProvider.bankPassBookImage,
                              policeClearanceCertificateOrJudgementCopyImage:
                                  registrationProvider
                                      .policeClearenceCertificateOrJudgementCopyImage,
                              aadhaarCardFrontImage:
                                  registrationProvider.aadhaarCardFronSideImage,
                              aadhaarCardBackImage:
                                  registrationProvider.aadhaarCardBackSideImage,
                              panCardImage: registrationProvider.panCardImage,

                              registrationCertificateImage:
                                  registrationProvider
                                      .registrationCertificateImage,
                              vehicleInsuranceImage:
                                  registrationProvider.vehicleInsuranceImage,
                              certificateOfFitnessImage:
                                  registrationProvider
                                      .certificateOfFitnessImage,
                              vehiclePermitImage:
                                  registrationProvider.vehiclePermitImage,
                            )
                            .then((_) {
                              Navigator.pop(context);
                            });
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
