class Driver {
  final String id;
  final String name;
  final String mobileNumber;
  final String address;

  Driver({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.address,
  });

  // Define the toMap method to convert the object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'address': address,
    };
  }

  // Define a fromMap factory constructor to create an object from a Map
  factory Driver.fromMap(Map<String, dynamic> map, String documentId) {
    return Driver(
      id: documentId,
      name: map['name'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }
}
