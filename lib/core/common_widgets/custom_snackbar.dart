import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 130,
            right: 20.0,
            left: 20.0),
        backgroundColor: isError ? Colors.red : Colors.green,
        content: Text(message),
      ),
    );
  }
}
