import 'package:flutter/material.dart';

Widget buildLabelProfilInfo() {
  return Container(
    margin: const EdgeInsets.only(
      left: 30.0,
      right: 20.0,
    ),
    child: Text(
      'Mes infos',
      style: const TextStyle().copyWith(fontWeight: FontWeight.bold),
    ),
  );
}
