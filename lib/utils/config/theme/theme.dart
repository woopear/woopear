import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';
import 'package:woopear/utils/config/theme/app_bar_theme.dart';
import 'package:woopear/utils/config/theme/card_theme.dart';
import 'package:woopear/utils/config/theme/elevated_button_theme.dart';
import 'package:woopear/utils/config/theme/icon_theme.dart';
import 'package:woopear/utils/config/theme/input_decoration_theme.dart';
import 'package:woopear/utils/config/theme/text_button_style.dart';

/// theme mode claire
final themeClaire = WooTheme.modeClair(
  scaffolBackground: Colors.white,

  /// couleur principal
  primary: const Color(0xFF0090E1),
  secondary: const Color(0xFFAD00FF),
  tertiary: const Color(0xFFE3CC00),

  /// text
  tbodyPrincipal: GoogleFonts.nunito(fontSize: 20.0),
  tbodySecondaire: GoogleFonts.nunito(fontSize: 16.0),
  tPrincipalBoxDialogue: GoogleFonts.nunito(),
  tButton: GoogleFonts.nunito(),
  tBoxDialogue: GoogleFonts.nunito(),
  t1: GoogleFonts.nunito(color: Colors.black),
  t2: GoogleFonts.nunito(color: Colors.black),
  t3: GoogleFonts.nunito(color: Colors.black),
  t4: GoogleFonts.nunito(color: Colors.black),
  tsmall: GoogleFonts.nunito(color: Colors.black),

  /// button
  textButtonStyle: textButtonStyleClaire,
  elevatedButtonTheme: elevatedButtonClaire,

  /// icon
  iconTheme: iconThemeClaire,

  /// input
  inputDecorationTheme: inputDecorationClaire,

  /// card
  cardTheme: cardThemeClaire,

  /// app bar
  appBarTheme: appBarThemeClaire,
);

/// theme mode dark
final themeDark = WooTheme.modeDark(
  scaffolBackground: const Color(0xFF36393F),

  /// couleur principal
  primary: const Color(0xFF40BAFF),
  secondary: const Color(0xFFC854FF),
  tertiary: const Color(0xFFFFE500),

  /// text
  tbodyPrincipal: GoogleFonts.nunito(fontSize: 20.0),
  tbodySecondaire: GoogleFonts.nunito(fontSize: 16.0),
  tPrincipalBoxDialogue: GoogleFonts.nunito(),
  tButton: GoogleFonts.nunito(),
  tBoxDialogue: GoogleFonts.nunito(),
  t1: GoogleFonts.nunito(color: Colors.white),
  t2: GoogleFonts.nunito(color: Colors.white),
  t3: GoogleFonts.nunito(color: Colors.white),
  t4: GoogleFonts.nunito(color: Colors.white),
  tsmall: GoogleFonts.nunito(color: Colors.white),

  /// button
  textButtonStyle: textButtonStyleDark,
  elevatedButtonTheme: elevatedButtonDark,

  /// icon
  iconTheme: iconThemeDark,

  /// input
  inputDecorationTheme: inputDecorationDark,

  /// card
  cardTheme: cardThemeDark,

  /// app bar
  appBarTheme: appBarThemeDark,
);
