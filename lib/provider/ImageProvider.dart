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

class AdharProvider with ChangeNotifier {
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

class PanProvider with ChangeNotifier {
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

class BankProvider with ChangeNotifier {
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

class PoliceProvider with ChangeNotifier {
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

class RegistrationnProvider with ChangeNotifier {
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

class InsuranceProvider with ChangeNotifier {
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

class FitnessProvider with ChangeNotifier {
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

class VehicleProvider with ChangeNotifier {
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
