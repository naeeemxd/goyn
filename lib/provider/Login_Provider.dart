import 'package:flutter/material.dart';
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
