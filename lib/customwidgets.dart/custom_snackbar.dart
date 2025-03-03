import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    ContentType contentType = ContentType.failure, // Default: Error type
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType, // failure, success, help, warning
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
