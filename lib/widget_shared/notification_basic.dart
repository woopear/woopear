import 'package:flutter/material.dart';

class NotificationBasic {
  String? text;
  bool? error;

  NotificationBasic({
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