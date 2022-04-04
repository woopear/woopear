import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/user/user_const.dart';

class UserState extends ChangeNotifier {
  final FirebaseAuth _user = FirebaseAuth.instance;
  final ProfilState profil = ProfilState();

  /// fonction de connection du user
  Future<void> connexionUser(
      TextEditingController email, TextEditingController password) async {
    await _user.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
    notifyListeners();
  }

  // fonction création user
  Future<void> SendConnexionUser(TextEditingController email) async {
    /// creation config envoie email
    ActionCodeSettings acs = ActionCodeSettings(
      url: UserConst.createUrlRedirectSendMail,
      handleCodeInApp: true,
    );

    /// envoie email de connection
    await _user.sendSignInLinkToEmail(
        email: email.text.trim(), actionCodeSettings: acs);
    notifyListeners();
  }

  // fonction qui déconnecte le userCurrent
  Future<void> disconnectUser() async {
    await _user.signOut();
    profil.resetProfil();
    notifyListeners();
  }

  /// fonction pour effacer un user
  Future<void> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}

/// state de la cass UserState
final userChange = ChangeNotifierProvider<UserState>((ref) => UserState());
