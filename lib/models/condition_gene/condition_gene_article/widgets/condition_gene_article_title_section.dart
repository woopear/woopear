import 'package:flutter/material.dart';

Widget buildTitleSectionConditionGeneArticle(
    String text, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 70.0),
    child: Text(
      text,
      style: const TextStyle().copyWith(
        fontSize: 22.0,
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
