import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoProvider with ChangeNotifier {
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners(); // Notify listeners when the image changes
    }
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners(); // Notify listeners when the image is cleared
  }
}