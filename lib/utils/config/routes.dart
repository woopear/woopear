import 'package:flutter/material.dart';
import 'package:woopear/pages/home.dart';
import 'package:woopear/pages/john.dart';

class Routes {
  /// les routes
  final String _home = '/';
  final String _john = '/john';

  /// les getters des routes
  String get home => _home;
  String get john => _john;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const Home(),
      _john: (context) => const John(),
    };
  }
}
