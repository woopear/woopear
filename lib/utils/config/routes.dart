import 'package:flutter/material.dart';
import 'package:woopear/pages/app.dart';
import 'package:woopear/pages/create_user.dart';
import 'package:woopear/pages/forgot_password.dart';
import 'package:woopear/pages/home.dart';
import 'package:woopear/pages/john.dart';
import 'package:woopear/pages/private/account/account.dart';
import 'package:woopear/pages/private/presentation/presentation.dart';
import 'package:woopear/pages/private/profil/profil.dart';

class Routes {
  /// les routes
  final String _home = '/';
  final String _appAcces = '/app';
  final String _profil = '/app/profil';
  final String _account = '/app/account';
  final String _presentation = '/app/presentation';
  final String _createUser = '/create/account';
  final String _forgotPassword = '/forgot/password';
  final String _john = '/john';

  /// les getters des routes
  String get home => _home;
  String get appAcces => _appAcces;
  String get createUser => _createUser;
  String get profil => _profil;
  String get forgotPassword => _forgotPassword;
  String get account => _account;
  String get presentation => _presentation;
  String get john => _john;

  /// retourne un widget en fonction de la routes
  Map<String, Widget Function(BuildContext)> urls() {
    return {
      _home: (context) => const Home(),
      _appAcces: (context) => const AppAcces(),
      _createUser: (context) => const CreateUser(),
      _profil: (context) => const ProfilPage(),
      _forgotPassword: (context) => const ForgotPassword(),
      _account: (context) => const Account(),
      _presentation: (context) => const Presentation(),
      _john: (context) => const John(),
    };
  }
}
