import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnionRegistration extends StatelessWidget {
  const UnionRegistration({super.key});
  static final TextEditingController unionController = TextEditingController();
  static final TextEditingController registrationController =
      TextEditingController();

  Future<void> registerUnion(BuildContext context) async {
    String unionName = unionController.text.trim();
    String registrationNumber = registrationController.text.trim();

    // Input validation
    if (unionName.isEmpty || registrationNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          duration: Durations.medium4,
        ),
      );
      return;
    }

    // Check if registration number is numeric
    if (!RegExp(r'^[0-9]+$').hasMatch(registrationNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration number must be numeric"),
          duration: Durations.medium4,
        ),
      );
      return;
    }

    String docId =
        DateTime.now().millisecondsSinceEpoch
            .toString(); // Generate timestamp ID

    try {
      // Check if union with the same name already exists
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection("unions")
              .where("UNION_NAME", isEqualTo: unionName)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("A union with this name already exists"),
            duration: Durations.medium4,
          ),
        );
        return;
      }

      // Add union to Firestore
      await FirebaseFirestore.instance.collection("unions").doc(docId).set({
        "UNION_NAME": unionName,
        "REGISTRATION_NUMBER": registrationNumber,
        "created_at": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Union Registered Successfully!"),
          duration: Durations.medium4,
        ),
      );

      // Clear input fields
      unionController.clear();
      registrationController.clear();
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Firestore Error: ${e.message}"),
          duration: Durations.medium4,
        ),
      );
    } catch (e) {
      // Handle generic errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          duration: Durations.medium4,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Union Registration"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(label: "Union name", controller: unionController),
            const SizedBox(height: 16), // Add spacing
            CustomTextField(
              keyboardType: TextInputType.number,
              label: "Registration number",
              controller: registrationController,
            ),
            const Spacer(),
            CustomButton(
              title: "Logout",
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out successfully")),
                );
              },
            ),
            CustomButton(
              title: "Register",
              color: const Color(0xFFF0AC00),
              onTap: () => registerUnion(context),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> addDummyUnions() async {
//   final CollectionReference unions = FirebaseFirestore.instance.collection(
//     "unions",
//   );

//   for (int i = 1; i <= 100; i++) {
//     String docId =
//         DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID

//     await unions.doc(docId).set({
//       "UNION_NAME": "Union $i",
//       "REGISTRATION_NUMBER": "REG-${1000 + i}",
//       "created_at": FieldValue.serverTimestamp(),
//     });

//     await Future.delayed(
//       const Duration(milliseconds: 50),
//     ); // Small delay to avoid duplicates
//   }

//   print("✅ 100 Unions Added!");
// }

// Future<void> deleteAllUnions() async {
//   final CollectionReference unions = FirebaseFirestore.instance.collection(
//     "unions",
//   );

//   QuerySnapshot querySnapshot = await unions.get();

//   for (var doc in querySnapshot.docs) {
//     await doc.reference.delete();
//   }

//   print("🗑️ All unions deleted!");
// }
