import 'package:flutter/material.dart';
import 'package:woopear/pages/connexion.dart';
import 'package:woopear/pages/create_user.dart';
import 'package:woopear/pages/home.dart';
import 'package:woopear/pages/john.dart';
import 'package:woopear/pages/private/dashboard.dart';
import 'package:woopear/pages/private/profil/create_profil.dart';

class Routes {
  /// les routes
  final String _home = '/';
  final String _connexion = '/connexion';
  final String _dashboard = '/dashboard';
  final String _createUser = '/createaccount';
  final String _createProfil = '/profil/create';
  final String _john = '/john';

  /// les getters des routes
  String get home => _home;
  String get connexion => _connexion;
  String get dashboard => _dashboard;
  String get createUser => _createUser;
  String get createProfil => _createProfil;
  String get john => _john;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const Home(),
      _connexion: (context) => const Connexion(),
      _dashboard: (context) => const Dashboard(),
      _createUser: (context) => const CreateUser(),
      _createProfil: (context) => const CreateProfil(),
      _john: (context) => const John(),
    };
  }
}
