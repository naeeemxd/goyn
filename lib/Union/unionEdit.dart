import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goyn/customwidgets.dart/Custom_Widgets.dart';
import 'package:goyn/login_screen.dart';
import 'package:goyn/provider/Union_Provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnionEdit extends StatefulWidget {
  final String unionDocId;

  const UnionEdit({super.key, required this.unionDocId});

  @override
  State<UnionEdit> createState() => _UnionEditState();
}

class _UnionEditState extends State<UnionEdit> {
  final TextEditingController unionController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUnionData();
  }

  Future<void> fetchUnionData() async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance
              .collection("unions")
              .doc(widget.unionDocId)
              .get();

      if (doc.exists) {
        setState(() {
          unionController.text = doc["union_name"];
          registrationController.text = doc["registration_number"];
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching union: $e")));
    }
  }

  Future<void> updateUnion(BuildContext context) async {
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
          .doc(widget.unionDocId)
          .update({
            "union_name": unionName,
            "registration_number": registrationNumber,
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Union Updated Successfully!")),
      );

      Provider.of<UnionProvider>(context, listen: false).fetchUnions();
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Firestore Error: ${e.message}")));
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
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
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
                      onTap: () => updateUnion(context),
                    ),
                  ],
                ),
              ),
    );
  }
}
