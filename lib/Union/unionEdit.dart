import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';

class UnionEdit extends StatelessWidget {
  final String unionDocId;

  const UnionEdit({super.key, required this.unionDocId});

  Future<DocumentSnapshot> fetchUnionData() async {
    return await FirebaseFirestore.instance
        .collection("unions")
        .doc(unionDocId)
        .get();
  }

  Future<void> updateUnion(
    BuildContext context,
    TextEditingController unionController,
    TextEditingController registrationController,
  ) async {
    String unionName = unionController.text.trim();
    String registrationNumber = registrationController.text.trim();

    if (unionName.isEmpty || registrationNumber.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(registrationNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration number must be numeric")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection("unions")
          .doc(unionDocId)
          .update({
            "UNION_NAME": unionName,
            "REGISTRATION_NUMBER": registrationNumber,
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Union Updated Successfully!")),
      );

      Provider.of<UnionProvider>(context, listen: false).fetchUnions();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Union"),
      body: FutureBuilder<DocumentSnapshot>(
        future: fetchUnionData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var doc = snapshot.data!;
          TextEditingController unionController = TextEditingController(
            text: doc["UNION_NAME"],
          );
          TextEditingController registrationController = TextEditingController(
            text: doc["REGISTRATION_NUMBER"],
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomTextField(
                  label: "Union name",
                  controller: unionController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  label: "Registration number",
                  controller: registrationController,
                ),
                const Spacer(),
                CustomButton(
                  title: "Update",
                  color: const Color(0xFFF0AC00),
                  onTap:
                      () => updateUnion(
                        context,
                        unionController,
                        registrationController,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
