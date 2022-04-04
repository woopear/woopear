import 'package:flutter/material.dart';
import 'package:woopear/pages/connexion.dart';
import 'package:woopear/pages/home.dart';
import 'package:woopear/pages/john.dart';
import 'package:woopear/pages/private/dashboard.dart';

class Routes {
  /// les routes
  final String _home = '/';
  final String _connexion = '/connexion';
  final String _dashboard = '/dashboard';
  final String _john = '/john';

  /// les getters des routes
  String get home => _home;
  String get connexion => _connexion;
  String get dashboard => _dashboard;
  String get john => _john;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const Home(),
      _connexion: (context) => const Connexion(),
      _dashboard: (context) => const Dashboard(),
      _john: (context) => const John(),
    };
  }
}
