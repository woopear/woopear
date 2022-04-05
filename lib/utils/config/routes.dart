import 'package:flutter/material.dart';
import 'package:woopear/pages/app.dart';
import 'package:woopear/pages/create_user.dart';
import 'package:woopear/pages/david.dart';
import 'package:woopear/pages/forgot_password.dart';
import 'package:woopear/pages/home.dart';
import 'package:woopear/pages/john.dart';
import 'package:woopear/pages/private/profil/create_profil.dart';

class Routes {
  /// les routes
  final String _home = '/';
  final String _appAcces = '/app';
  final String _createUser = '/create/account';
  final String _createProfil = '/app/profil/create';
  final String _forgotPassword = '/forgot/password';
  final String _john = '/john';
  final String _david = '/david';

  /// les getters des routes
  String get home => _home;
  String get appAcces => _appAcces;
  String get createUser => _createUser;
  String get createProfil => _createProfil;
  String get forgotPassword => _forgotPassword;
  String get john => _john;
  String get david => _david;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const Home(),
      _appAcces: (context) => const AppAcces(),
      _createUser: (context) => const CreateUser(),
      _createProfil: (context) => const CreateProfil(),
      _forgotPassword: (context) => const ForgotPassword(),
      _john: (context) => const John(),
      _david: (context) => const David(),
    };
  }
}
