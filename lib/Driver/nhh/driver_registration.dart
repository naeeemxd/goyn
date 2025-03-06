import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class DBDriverRegistration {
  Future<void> driverRequirementsSaveToFirestoreDataBase({
    required String driverName,
    required String driverMobileNumber,
    required String unionDocId,
    required String driverAddress,
    required String memberOfUnionName,

    // IDs
    required String bankPassBookOrCheckNumber,
    required String policeClearanceCertificateOrJudgementCopy,
    required String aadhaarCardNumber,
    required String panCardNumber,
    required String registrationCertificateNumber,
    required String vehicleInsuranceNumber,
    required String certificateOfFitnessNumber,
    required String vehiclePermitNumber,

    // Images
    required File? bankPassBookOrCheckImage,
    required File? policeClearanceCertificateOrJudgementCopyImage,
    required File? aadhaarCardFrontImage,
    required File? aadhaarCardBackImage,
    required File? panCardImage,
    required File? registrationCertificateImage,
    required File? vehicleInsuranceImage,
    required File? certificateOfFitnessImage,
    required File? vehiclePermitImage,
  }) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('Driver_Registration').doc();

      // Store basic driver details
      await docRef.set({
        "NAME": driverName,
        "PHONE": driverMobileNumber,
        "ADDRESS": driverAddress,
        "UNION_NAME": memberOfUnionName,
        "UNION_ID": unionDocId,

        ///
        "ADDED_BY": 'ADMIN',

        ///
        "ADDED_TYPE": 'ADMIN',

        ///
        "ADDED_DATE": Timestamp.now(),

        ///
        "STATUS": 'ACTIVE',

        ///
      });
      // Store mapped fields with ID numbers and corresponding images
      await _uploadDocument(
        docRef,
        "PASSBOOK",
        bankPassBookOrCheckNumber,
        bankPassBookOrCheckImage,
      );
      await _uploadDocument(
        docRef,
        "POLICE_CLEARENCE_CERTIFICATE",
        policeClearanceCertificateOrJudgementCopy,
        policeClearanceCertificateOrJudgementCopyImage,
      );
      await _uploadDocument(
        docRef,
        "ADHAAR",
        aadhaarCardNumber,
        aadhaarCardFrontImage,
      );
      await _uploadDocument(docRef, "PAN_CARD", panCardNumber, panCardImage);
      await _uploadDocument(
        docRef,
        "VEHICLE_REGISTRATION_CERTIFICATE",
        registrationCertificateNumber,
        registrationCertificateImage,
      );
      await _uploadDocument(
        docRef,
        "VEHICLE_INSURANCE_CERTIFICATE",
        vehicleInsuranceNumber,
        vehicleInsuranceImage,
      );
      await _uploadDocument(
        docRef,
        "VEHICLE_FITNESS_CERTIFICATE",
        certificateOfFitnessNumber,
        certificateOfFitnessImage,
      );
      await _uploadDocument(
        docRef,
        "VEHICLE_PERMIT",
        vehiclePermitNumber,
        vehiclePermitImage,
      );

      print("Driver details successfully saved.");
    } on FirebaseException catch (e) {
      print("Firestore Error: ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
    }
  }

  /// Uploads ID Number and corresponding image as a **map** in Firestore.
  Future<void> _uploadDocument(
    DocumentReference docRef,
    String fieldName,
    String idNumber,
    File? imageFile,
  ) async {
    try {
      Map<String, dynamic> documentData = {"NUMBER": idNumber};

      if (imageFile != null) {
        Uint8List? compressedImage = await _compressImage(imageFile);
        if (compressedImage != null) {
          documentData["PHOTO"] = base64Encode(compressedImage);
        }
      }

      await docRef.update({fieldName: documentData});
      print("$fieldName uploaded successfully.");
    } catch (e) {
      print("Error uploading $fieldName: $e");
    }
  }

  /// Compress image before uploading
  Future<Uint8List?> _compressImage(File file) async {
    try {
      return await FlutterImageCompress.compressWithList(
        await file.readAsBytes(),
        quality: 40,
        minWidth: 700,
        minHeight: 200,
        format: CompressFormat.jpeg,
      );
    } catch (e) {
      print("Image compression failed: $e");
      return null;
    }
  }
}
