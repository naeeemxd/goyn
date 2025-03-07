import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher extends StatelessWidget {
  const WhatsAppLauncher({super.key});

  Future<void> openWhatsApp() async {
    const phone = "1234567890"; // Replace with actual number
    const message = "Hello, I need some help!";
    final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WhatsApp Launcher")),
      body: Center(
        child: ElevatedButton(
          onPressed: openWhatsApp,
          child: const Text("Open WhatsApp"),
        ),
      ),
    );
  }
}
