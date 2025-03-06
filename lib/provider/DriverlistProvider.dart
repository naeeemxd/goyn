import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  // Convert Firestore document to Driver model
  factory Driver.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Driver(
      id: doc.id,
      name: data['NAME'] ?? 'Unknown',
      phone: data['PHONE'] ?? 'No Number',
      imageUrl:
          data['profileImage'] ??
          'https://tse4.mm.bing.net/th?id=OIP.OYbzbbyzogwtriubL2pP0AHaHa&pid=Api&P=0&h=220',
    );
  }
}

class DriverlistProvider extends ChangeNotifier {
  List<Driver> _drivers = [];
  List<Driver> _filteredDrivers = [];

  List<Driver> get filteredDrivers => _filteredDrivers;

  // Fetch Data from Firestore
  Future<void> fetchDrivers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('Driver_Registration')
              .get();

      _drivers = snapshot.docs.map((doc) => Driver.fromFirestore(doc)).toList();
      _filteredDrivers = _drivers; // Initially, filtered list = full list

      notifyListeners();
    } catch (e) {
      print("Error fetching drivers: $e");
    }
  }

  // Search Filter
  void setSearchQuery(String query) {
    if (query.isEmpty) {
      _filteredDrivers = _drivers;
    } else {
      _filteredDrivers =
          _drivers
              .where(
                (driver) =>
                    driver.name.toLowerCase().contains(query.toLowerCase()) ||
                    driver.phone.contains(query),
              )
              .toList();
    }
    notifyListeners();
  }
}
