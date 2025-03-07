import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String getRandomImageUrl() {
  final random = Random().nextInt(1000); // Generate a random number
  return "https://picsum.photos/300/400?random=$random";
}

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
      imageUrl: data['profileImage'] ?? getRandomImageUrl(),
    );
  }
}

class DriverlistProvider extends ChangeNotifier {
  List<Driver> _drivers = [];
  List<Driver> _filteredDrivers = [];

  List<Driver> get filteredDrivers => _filteredDrivers;

  // Fetch Data from Firestore based on unionDocId
  Future<void> fetchDrivers(String? unionDocId) async {
    try {
      print("Fetching drivers for UNION_ID: $unionDocId");

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('Driver_Registration')
              .where(
                'UNION_ID', // Ensure this matches Firestore field name
                isEqualTo: unionDocId,
              )
              .get();

      print("Total Drivers Found: ${snapshot.docs.length}");

      _drivers = snapshot.docs.map((doc) => Driver.fromFirestore(doc)).toList();
      _filteredDrivers = List.from(_drivers); // Initialize filtered list

      notifyListeners(); // 🔥 Notify UI to rebuild

      for (var driver in _drivers) {
        print("Driver Name: ${driver.name}, Phone: ${driver.phone}");
      }
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
