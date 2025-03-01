// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:goyn/FirebaseHelper/Union.dart';
// import 'package:goyn/customwidgets.dart/CustomAppBar.dart';
// import 'package:goyn/customwidgets.dart/custom_button.dart';
// import 'package:goyn/customwidgets.dart/custom_textfield.dart';

// class UnionRegistration extends StatelessWidget {
//   const UnionRegistration({super.key});
//   static final TextEditingController unionController = TextEditingController();
//   static final TextEditingController registrationController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: "Union Registration"),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CustomTextField(label: "Union name", controller: unionController),
//             const SizedBox(height: 16), // Add spacing
//             CustomTextField(
//               keyboardType: TextInputType.number,
//               label: "Registration number",
//               controller: registrationController,
//             ),
//             const Spacer(),
//             // CustomButton(
//             //   title: "add",
//             //   color: const Color(0xFFF0AC00),
//             //   onTap: () => deleteAllUnions(),
//             // ),
//             CustomButton(
//               title: "Register",
//               color: const Color(0xFFF0AC00),
//               onTap:
//                   () => registerUnion(
//                     context,
//                     unionController,
//                     registrationController,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Future<void> addDummyUnions() async {
// //   final CollectionReference unions = FirebaseFirestore.instance.collection(
// //     "unions",
// //   );

// //   for (int i = 1; i <= 100; i++) {
// //     String docId =
// //         DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID

// //     await unions.doc(docId).set({
// //       "union_name": "Union $i",
// //       "registration_number": "REG-${1000 + i}",
// //       "created_at": FieldValue.serverTimestamp(),
// //     });

// //     await Future.delayed(
// //       const Duration(milliseconds: 50),
// //     ); // Small delay to avoid duplicates
// //   }

// //   print("✅ 100 Unions Added!");
// // }

// // Future<void> deleteAllUnions() async {
// //   final CollectionReference unions = FirebaseFirestore.instance.collection(
// //     "unions",
// //   );

// //   QuerySnapshot querySnapshot = await unions.get();

// //   for (var doc in querySnapshot.docs) {
// //     await doc.reference.delete();
// //   }

// //   print("🗑️ All unions deleted!");
// // }
