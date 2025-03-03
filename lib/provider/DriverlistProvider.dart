import 'package:flutter/material.dart';

// Driver Model
class Driver {
  final String id;
  final String name;
  final String phone;
  final String imageUrl;

  Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.imageUrl,
  });
}

// DriverlistProvider
class DriverlistProvider with ChangeNotifier {
  List<Driver> _drivers = [
    Driver(
      id: '1',
      name: 'Muhammed Junaid C',
      phone: '98765 43210',
      imageUrl: 'https://loremflickr.com/320/240/person',
    ),
    Driver(
      id: '2',
      name: 'John Doe',
      phone: '12345 67890',
      imageUrl: 'https://loremflickr.com/320/240/man',
    ),
    Driver(
      id: '3',
      name: 'Jane Smith',
      phone: '54321 09876',
      imageUrl: 'https://loremflickr.com/320/240/woman',
    ),
    Driver(
      id: '1',
      name: 'Muhammed Junaid C',
      phone: '98765 43210',
      imageUrl: 'https://loremflickr.com/320/240/person',
    ),
    Driver(
      id: '2',
      name: 'John Doe',
      phone: '12345 67890',
      imageUrl: 'https://loremflickr.com/320/240/man',
    ),
    Driver(
      id: '3',
      name: 'Jane Smith',
      phone: '54321 09876',
      imageUrl: 'https://loremflickr.com/320/240/woman',
    ),
    Driver(
      id: '1',
      name: 'Muhammed Junaid C',
      phone: '98765 43210',
      imageUrl: 'https://loremflickr.com/320/240/person',
    ),
    Driver(
      id: '2',
      name: 'John Doe',
      phone: '12345 67890',
      imageUrl: 'https://loremflickr.com/320/240/man',
    ),
    Driver(
      id: '3',
      name: 'Jane Smith',
      phone: '54321 09876',
      imageUrl: 'https://loremflickr.com/320/240/woman',
    ),
    // Add more drivers as needed
  ];

  String _searchQuery = '';

  // Getter for the list of drivers
  List<Driver> get drivers => _drivers;

  // Getter for the filtered list of drivers
  List<Driver> get filteredDrivers {
    if (_searchQuery.isEmpty) {
      return _drivers;
    } else {
      return _drivers
          .where(
            (driver) =>
                driver.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  // Setter for the search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}

class FilterProvider with ChangeNotifier {
  String _currentFilter = 'All';

  // Getter for the current filter
  String get currentFilter => _currentFilter;

  // Setter for the current filter
  void setFilter(String filter) {
    _currentFilter = filter;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
