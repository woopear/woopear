import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appBarThemeClaire = AppBarTheme(
  titleTextStyle: GoogleFonts.nunito(
    fontSize: 30.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);

final appBarThemeDark = AppBarTheme(
  titleTextStyle: GoogleFonts.nunito(
    color: Colors.white,
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  ),
  backgroundColor: const Color(0xFF40BAFF),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);
