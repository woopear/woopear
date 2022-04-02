import 'package:flutter/material.dart';

class Notification {
  String? text;
  bool? error;

  Notification({
    Key? key,
    required this.text,
    required this.error,
  });

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notification(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text!,
          style: TextStyle(
            color: error! ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}