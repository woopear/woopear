import 'package:flutter/material.dart';

Widget buildLabelPartieFormulairePresentation(
    String text, EdgeInsetsGeometry? margin, BuildContext context) {
  return Container(
    margin: margin,
    child: Text(
      text,
      style: const TextStyle().copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}
