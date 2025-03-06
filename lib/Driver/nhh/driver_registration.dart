import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class DBDriverRegistration {
  Future<void> driverRequirementsSaveToFirestoreDataBase({
    required String driverName,
    required String driverMobileNumber,
    required String driverAddress,
    required String driverEmail,
    // required String areYouMemberOfAnyUnion,
    required String memberOfUnionName,
    required String bankPassBookOrCheckNumber,
    required String policeClearanceCertificateOrJudgementCopy,
    required String aadhaarCard,
    required String panCard,
    required String registrationCertificate,
    required String vehicleInsurance,
    required String certificateOfFitness,
    required String vehiclePermit,
    required File? bankPassBookOrCheckImages,
    required File? policeClearanceCertificateOrJudgementCopyImage,
    required File? aadhaarCardFrontImage,
    required File? aadhaarCardBackImage,
    required File? panCardImage,
    required File? registrationCertificateImage,
    required File? vehicleInsuranceImage,
    required File? certificateOfFitnessImage,
    required File? vehiclePermitImage,
  }) async {
    // List of images with their corresponding variable names
    Map<String, File?> images = {
      'bankPassBookImages': bankPassBookOrCheckImages,
      'policeClearanceCertificateImage':
          policeClearanceCertificateOrJudgementCopyImage,
      'aadhaarCardFrontImage': aadhaarCardFrontImage,
      'aadhaarCardBackImage': aadhaarCardBackImage,
      'panImage': panCardImage,
      'registrationCertificateImage': registrationCertificateImage,
      'vehicleInsuranceImage': vehicleInsuranceImage,
      'certificateOfFitnessImage': certificateOfFitnessImage,
      'vehiclePermitImage': vehiclePermitImage,
    };

    // Map to store Base64 encoded images
    Map<String, dynamic> encodedImages = {};
    // Loop through each image and encode it

    for (var entry in images.entries) {
      if (entry.value != null) {
        var compressedImage = await _compressImage(entry.value!);

        if (compressedImage != null) {
          String base64Image = base64Encode(compressedImage);
          encodedImages[entry.key] = base64Image;

          // Calculate Image Size
          // int byteSize = compressedImage.lengthInBytes; // Directly get byte length
          // double sizeMB = byteSize / (1024 * 1024);

          // print('${entry.key.runtimeType} compressed size: ${sizeMB.toStringAsFixed(2)} MB');
        }
      }
    }

    try {
      await FirebaseFirestore.instance
          .collection('Driver_Registration')
          .doc()
          .set({
            // Driver Personl details
            "driverName": driverName,
            "driverMobileNumber": driverMobileNumber,
            "driverAddress": driverAddress,
            "driverEmail": driverEmail,
            // "areYouMemberOfAnyUnion": areYouMemberOfAnyUnion,
            "memberOfUnionname": memberOfUnionName,

            // Driver Requirements ID Numbers
            "bankPassBookOrCheckNumber": bankPassBookOrCheckNumber,
            "policeClearanceCertificateOrJudgementCopyNumber":
                policeClearanceCertificateOrJudgementCopy,
            "aadhaarCardNumber": aadhaarCard,
            "panCardNumber": panCard,

            // Vehicle Requirements ID Numbers
            "registrationCertificateNumber": registrationCertificate,
            "vehicleInsuranceNumber": vehicleInsurance,
            "certificateOfFitnessNumber": certificateOfFitness,
            "vehiclePermitNumber": vehiclePermit,

            // Driver Requirements Images
            'bankPassBookImages': encodedImages['bankPassBookImages'],
            'policeClearanceCertificateImage':
                encodedImages['policeClearanceCertificateImage'],
            'aadhaarCardFrontImage': encodedImages['aadhaarCardFrontImage'],
            'aadhaarCardBackImage': encodedImages['aadhaarCardBackImage'],
            'panImage': encodedImages['panImage'],

            // vehicle Requirements Images
            'registrationCertificateImage':
                encodedImages['registrationCertificateImage'],
            'vehicleInsuranceImage': encodedImages['vehicleInsuranceImage'],
            'certificateOfFitnessImage':
                encodedImages['certificateOfFitnessImage'],
            'vehiclePermitImage': encodedImages['vehiclePermitImage'],
          });

      print("Driver details successfully saved.");
    } on FirebaseException catch (e) {
      print("Firestore Error: ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
    }
  }

  Future<Uint8List?> _compressImage(File file) async {
    try {
      Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
        await file.readAsBytes(), // Read file as bytes
        quality: 50, // Compression quality (0-100)
        minWidth: 800, // Set desired width
        minHeight: 200, // Set desired height
        format: CompressFormat.jpeg, // Ensure compressed format
      );

      print("Compressed image size: ${compressedBytes.lengthInBytes} bytes");
      return compressedBytes;
    } catch (e) {
      print("Image compression failed: $e");
      return null;
    }
  }
}
