import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CountryCodeProvider extends ChangeNotifier {
  late String selectedCountryCode;
  late String selectedCountryName;
  bool isDropdownOpen = false;
  Map<String, String> filteredCountryCodes = {};
  final Map<String, String> countryCodes;
  final TextEditingController searchController = TextEditingController();

  CountryCodeProvider({required this.countryCodes}) {
    // Default to the first country in the map
    selectedCountryName = countryCodes.keys.first;
    selectedCountryCode = countryCodes.values.first;
    filteredCountryCodes = Map.from(countryCodes);
    searchController.addListener(_filterCountryCodes);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCountryCodes);
    searchController.dispose();
    super.dispose();
  }

  void _filterCountryCodes() {
    if (searchController.text.isEmpty) {
      filteredCountryCodes = Map.from(countryCodes);
    } else {
      String query = searchController.text.toLowerCase();
      filteredCountryCodes = Map.fromEntries(
        countryCodes.entries.where((entry) {
          return entry.key.toLowerCase().contains(query) ||
              entry.value.toLowerCase().contains(query);
        }),
      );
    }
    notifyListeners();
  }

  void toggleDropdown() {
    isDropdownOpen = !isDropdownOpen;
    notifyListeners();
  }

  void selectCountry(String name, String code) {
    selectedCountryName = name;
    selectedCountryCode = code;
    isDropdownOpen = false;
    notifyListeners();
  }

  void closeDropdown() {
    isDropdownOpen = false;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    _filterCountryCodes();
  }
}


// 

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _otp = "";
  String get otp => _otp;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Generate a random 6-digit OTP
  String _generateOTP() {
    Random random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  // Check if user exists in Firebase
  Future<bool> checkUserExists(String phoneNumber) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNumber)
          .get();
      return userDoc.exists;
    } catch (e) {
      print("Error checking user: $e");
      return false;
    }
  }

  // Send OTP via API
  Future<bool> sendOTP(String mobileNumber) async {
    _otp = _generateOTP(); // Generate a new OTP
    notifyListeners();

    try {
      String template = "OTP+for+your+mobile+number+verification+is+$_otp.Spinecodes";
      final uri = Uri.parse(
        'https://m1.sarv.com/api/v2.0/sms_campaign.php'
        '?token=140634824266559c35cb5aa4.81948085'
        '&user_id=76595417'
        '&route=TR'
        '&template_id=13908'
        '&sender_id=SPINEO'
        '&language=EN'
        '&template=$template'
        '&contact_numbers=$mobileNumber',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }
}
