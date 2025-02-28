import 'package:flutter/material.dart';

class Union {
  final String name;
  final int drivers;

  Union({required this.name, required this.drivers});
}

// Provider for union list and search
class UnionProvider extends ChangeNotifier {
  // Sample data for unions
  final List<Union> _allUnions = [
    Union(name: 'Malappuramm', drivers: 39),
    Union(name: 'Perinthalmanna', drivers: 39),
    Union(name: 'Kozhikode', drivers: 39),
    Union(name: 'Chemmad', drivers: 39),
    Union(name: 'Manjeri', drivers: 39),
    Union(name: 'Nilambur', drivers: 39),
    Union(name: 'Kondotty', drivers: 39),
    Union(name: 'Wandoor', drivers: 39),
  ];

  List<Union> _filteredUnions = [];
  String _searchQuery = '';

  UnionProvider() {
    _filteredUnions = _allUnions;
  }

  List<Union> get unions => _filteredUnions;
  String get searchQuery => _searchQuery;
  int get unionCount => _allUnions.length;
  int get totalDrivers =>
      _allUnions.fold(0, (sum, union) => sum + union.drivers);

  void search(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredUnions = _allUnions;
    } else {
      _filteredUnions =
          _allUnions
              .where(
                (union) =>
                    union.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredUnions = _allUnions;
    notifyListeners();
  }
}
