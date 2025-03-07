// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ProfilePhotoProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class AdharProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class PanProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class BankProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class PoliceProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class RegistrationnProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class InsuranceProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class FitnessProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

// class VehicleProvider with ChangeNotifier {
//   File? _selectedImage;

//   File? get selectedImage => _selectedImage;

//   Future<void> pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       _selectedImage = File(pickedFile.path);
//       notifyListeners(); // Notify listeners when the image changes
//     }
//   }

//   void clearImage() {
//     _selectedImage = null;
//     notifyListeners(); // Notify listeners when the image is cleared
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationProvider with ChangeNotifier {
  File? _profilePhotoImage;
  bool _profilePhotoProcessCompleted = false;

  File? get profilePhotoImage => _profilePhotoImage;
  bool get profilePhotoProcessCompleted => _profilePhotoProcessCompleted;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        _profilePhotoImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void completeProfilePhotoProcess() {
    _profilePhotoProcessCompleted = true;
    notifyListeners();
  }
}
