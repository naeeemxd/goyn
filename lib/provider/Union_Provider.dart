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

  void fetchUnions() {
    FirebaseFirestore.instance.collection('unions').snapshots().listen((
      snapshot,
    ) {
      _unions = snapshot.docs.map((doc) => Union.fromFirestore(doc)).toList();
      notifyListeners();
    });
  }

  List<Union> searchUnions(String query) {
    if (query.isEmpty) {
      return _unions;
    }
    return _unions
        .where(
          (union) =>
              union.unionName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
