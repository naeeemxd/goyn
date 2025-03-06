import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goyn/Driver/nhh/app_colors.dart';
import 'package:goyn/Driver/nhh/custom_app_bar.dart';
import 'package:goyn/Driver/nhh/dashed_border_custom_painter.dart';
import 'package:goyn/Driver/nhh/registration_provider.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoUploadScreen extends StatelessWidget {
  final String title;
  final int detaileNumber;
  final bool completed;
  const PhotoUploadScreen({
    super.key,
    required this.title,
    required this.detaileNumber,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final registrationProvider = Provider.of<RegistrationProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: title, backButtonNeeded: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: ListView(
          children: [
            SizedBox(height: height * 0.02),
            Consumer<RegistrationProvider>(
              builder: (context, person, child) {
                final image = _requirmentsImages(detaileNumber, context);
                return image == null
                    ? Padding(
                      padding: EdgeInsets.only(bottom: height * 0.01),
                      child: Text(
                        "Let's find your $title",
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: black423,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                    : SizedBox();
              },
            ),
            Consumer<RegistrationProvider>(
              builder: (context, person, child) {
                final image = _requirmentsImages(detaileNumber, context);
                return image == null
                    ? Padding(
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      child: Text(
                        "Enter your $title and we'll get your information from GOYN."
                        " By sharing your $title details, you hereby confirm that you have"
                        " shared such details voluntarily.",
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: black423,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                    : SizedBox();
              },
            ),
            GestureDetector(
              onTap: () {
                registrationProvider.pickImage(
                  ImageSource.camera,
                  detaileNumber,
                );
              },
              child: Consumer<RegistrationProvider>(
                builder: (context, person, child) {
                  final imageDetails = _requirmentsImages(
                    detaileNumber,
                    context,
                  );
                  return imageDetails == null
                      ? CustomPaint(
                        painter: DashedBorderPainter(),
                        child: SizedBox(
                          height: height * 0.28,
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset(
                              //   'assets/images/photo_add_icon.svg',
                              //   fit: BoxFit.fill,
                              //   height: height * 0.06,
                              // ),
                              SizedBox(height: height * 0.012),
                              SizedBox(
                                width: width * 0.6,
                                child: Center(
                                  child: Text(
                                    'Add $title Front Side Photo',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: black423,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Container(
                        decoration: BoxDecoration(
                          color: grey5F5,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                          vertical: height * 0.1,
                        ),
                        child: Container(
                          height: height * 0.28,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(
                                _requirmentsImages(detaileNumber, context),
                              ),
                            ),
                          ),
                        ),
                      );
                },
              ),
            ),
            SizedBox(height: height * 0.025),
            if (title == 'Aadhaar card')
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: GestureDetector(
                  onTap: () {
                    registrationProvider.pickImage(ImageSource.camera, 4);
                  },
                  child: Consumer<RegistrationProvider>(
                    builder:
                        (context, person, child) =>
                            person.aadhaarCardBackSideImage == null
                                ? CustomPaint(
                                  painter: DashedBorderPainter(),
                                  child: SizedBox(
                                    height: height * 0.28,
                                    width: width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // SvgPicture.asset(
                                        //   'assets/images/photo_add_icon.svg',
                                        //   fit: BoxFit.fill,
                                        //   height: height * 0.06,
                                        // ),
                                        SizedBox(height: height * 0.012),
                                        SizedBox(
                                          width: width * 0.6,
                                          child: Center(
                                            child: Text(
                                              'Add $title back Side Photo',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                color: black423,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : Container(
                                  decoration: BoxDecoration(
                                    color: grey5F5,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.015,
                                    vertical: height * 0.1,
                                  ),
                                  child: Container(
                                    height: height * 0.28,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                          person.aadhaarCardBackSideImage!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                  ),
                ),
              ),
            !completed
                ? CustomTextField(
                  controller: _requirmentsController(detaileNumber, context),
                  label: 'Enter Your $title Number',
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title Number',
                      style: GoogleFonts.openSans(
                        fontSize: 10,
                        color: greyE9E,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      _requirmentsController(detaileNumber, context).text,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: black423,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Consumer<RegistrationProvider>(
          builder: (context, person, child) {
            File? imageData = _requirmentsImages(detaileNumber, context);
            File? aadharCardImage = _requirmentsImages(4, context);
            TextEditingController dataNumber = _requirmentsController(
              detaileNumber,
              context,
            );

            bool hasImageData = imageData?.path.isNotEmpty ?? false;
            bool hasAadharCardImage = aadharCardImage?.path.isNotEmpty ?? false;
            bool hasDataNumber = dataNumber.text.isNotEmpty;
            return CustomButton(
              title: "Save",
              color:
                  (title == 'Aadhaar card')
                      ? (hasImageData && hasDataNumber && hasAadharCardImage)
                          ? yellow701
                          : disabledButtoncolor
                      : (hasImageData && hasDataNumber)
                      ? yellow701
                      : disabledButtoncolor,
              onTap: () {
                (title == 'Aadhaar card')
                    ? (hasImageData && hasDataNumber && hasAadharCardImage)
                        ? person.setDataAddingProcessComplete(
                          detaileNumber,
                          context,
                        )
                        : null
                    : (hasImageData && hasDataNumber)
                    ? person.setDataAddingProcessComplete(
                      detaileNumber,
                      context,
                    )
                    : null;
              },
            );
          },
        ),
      ),
    );
  }

  _requirmentsImages(int detaileNumber, BuildContext context) {
    final person = Provider.of<RegistrationProvider>(context, listen: false);
    final imageMap = {
      0: person.bankPassBookImage,
      1: person.policeClearenceCertificateOrJudgementCopyImage,
      2: person.aadhaarCardFronSideImage,
      3: person.panCardImage,
      4: person.aadhaarCardBackSideImage,
      5: person.registrationCertificateImage,
      6: person.vehicleInsuranceImage,
      7: person.certificateOfFitnessImage,
      8: person.vehiclePermitImage,
    };

    final imageFile = imageMap[detaileNumber];

    if (imageFile != null) {
      return imageFile;
    }
  }

  _requirmentsController(int detaileNumber, BuildContext context) {
    final person = Provider.of<RegistrationProvider>(context, listen: false);
    final controllerMap = {
      0: person.bankPassBookOrCheckNumberController,
      1: person.policeClearenceCertificateOrJudgementCopyController,
      2: person.aadhaarCardController,
      3: person.panCardController,
      5: person.registrationCertificateController,
      6: person.vehicleInsuranceController,
      7: person.certificateOfFitnessController,
      8: person.vehiclePermitController,
    };

    final controller = controllerMap[detaileNumber];

    if (controller != null) {
      return controller;
    }
  }
}
