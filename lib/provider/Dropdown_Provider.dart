
import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {
  String _selectedValue = 'Yes'; // Default value

  String get selectedValue => _selectedValue;

  void updateValue(String newValue) {
    _selectedValue = newValue;
    notifyListeners(); // Notify UI to rebuild
  }
}
