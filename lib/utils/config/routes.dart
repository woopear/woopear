import 'package:flutter/material.dart';
import 'package:woopear/pages/home.dart';

class Routes {
  /// les routes
  final String _home = '/';

  /// les getters des routes
  String get home => _home;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const Home(),
    };
  }
}
