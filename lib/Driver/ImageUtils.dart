// image_utils.dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUtils {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Compress and convert image to base64
  Future<String?> compressAndConvertToBase64(File file) async {
    try {
      final compressedFile = await compressFile(file);

      if (compressedFile == null) {
        print('Compression failed.');
        return null;
      }

      final bytes = await compressedFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      return base64Image;
    } catch (e) {
      print('Error compressing or converting image: $e');
      return null;
    }
  }

  // Compress image file
  Future<File?> compressFile(File file) async {
    try {
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp*g'));
      final splitted = filePath.substring(0, lastIndex);
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      var dir = await path_provider.getTemporaryDirectory();
      String targetPath = "${dir.absolute.path}/temp.jpg";

      print('Source image path: $filePath');
      print('Target image path: $targetPath');

      var compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 85,
        rotate: 0,
      );

      if (compressedFile == null) {
        print('Image compression failed.');
        return null;
      }

      File compressedImageFile = File(compressedFile.path);

      print("File size before compression: ${file.lengthSync()}");
      print("File size after compression: ${compressedImageFile.lengthSync()}");

      return compressedImageFile;
    } catch (e) {
      print('Error during image compression: $e');
      return null;
    }
  }

  // Save base64 image to Firestore
  Future<void> saveImageToFirestore(String base64Image) async {
    try {
      await _firestore.collection('images').add({'base64Image': base64Image});
    } catch (e) {
      print('Error saving image to Firestore: $e');
      rethrow;
    }
  }

  // Fetch base64 image from Firestore
  Future<String?> fetchImageFromFirestore() async {
    try {
      final querySnapshot = await _firestore.collection('images').get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['base64Image'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching image from Firestore: $e');
      rethrow;
    }
  }
}
