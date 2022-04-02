import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final elevatedButtonDark = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
    textStyle: MaterialStateProperty.all<TextStyle?>(
      GoogleFonts.nunito(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
      const EdgeInsets.only(
        top: 18.0,
        bottom: 18.0,
        left: 18.0,
        right: 18.0,
      ),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder?>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
);

final elevatedButtonClaire = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
    textStyle: MaterialStateProperty.all<TextStyle?>(
      GoogleFonts.nunito(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
      const EdgeInsets.only(
        top: 18.0,
        bottom: 18.0,
        left: 18.0,
        right: 18.0,
      ),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder?>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
);
