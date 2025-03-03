import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goyn/model/unionModel.dart';

class SearchProvider extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }
}

class UnionProvider with ChangeNotifier {
  List<Union> _unions = [];
  List<Union> get unions => _unions;

  UnionProvider() {
    fetchUnions();
  }

  Future<void> fetchUnions() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('unions').get();
    _unions = snapshot.docs.map((doc) => Union.fromFirestore(doc)).toList();
    notifyListeners();
  }

  // Add this method to filter unions based on the search query
  List<Union> searchUnions(String query) {
    if (query.isEmpty) {
      return _unions; // Return all unions if the query is empty
    }
    return _unions
        .where(
          (union) =>
              union.unionName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
