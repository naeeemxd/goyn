import 'package:cloud_firestore/cloud_firestore.dart';

class Union {
  final String id;
  final String unionName;

  Union({
    required this.id,
    required this.unionName,
  });

  factory Union.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Union(
      id: doc.id,
      unionName: data['union_name'] ?? '',
    );
  }
}
