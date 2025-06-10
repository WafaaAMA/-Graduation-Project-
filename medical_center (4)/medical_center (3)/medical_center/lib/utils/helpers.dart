import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String message, {Color color = Colors.red}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
