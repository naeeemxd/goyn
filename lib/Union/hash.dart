import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class HashKeyGenerator extends StatefulWidget {
  @override
  _HashKeyGeneratorState createState() => _HashKeyGeneratorState();
}

class _HashKeyGeneratorState extends State<HashKeyGenerator> {
  String _hashKey = "Generating...";

  @override
  void initState() {
    super.initState();
    getAppHash();
  }

  Future<void> getAppHash() async {
    String? hash = await SmsAutoFill().getAppSignature;
    setState(() {
      _hashKey = hash ?? "Failed to generate hash.";
    });
    print("App Hash: $_hashKey");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Hash Generator")),
      body: Center(child: Text("App Hash:\n$_hashKey", textAlign: TextAlign.center)),
    );
  }
}
