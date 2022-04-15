import 'package:flutter/material.dart';

Widget buildArticleLabel(String text, BuildContext context) {
  return Container(
    child: Text(
      text,
      style: const TextStyle().copyWith(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
