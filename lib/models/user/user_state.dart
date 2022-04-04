import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/user/user_const.dart';

class UserState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ProfilState profil = ProfilState();

  /// fonction de connection du user
  Future<void> connexionUser(
      TextEditingController email, TextEditingController password) async {
    await _auth.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
    notifyListeners();
  }

  // fonction création user
  Future<void> createAuth(
      TextEditingController email,
      TextEditingController password,
      ProfilSchema profilSchema,
      String idProfil) async {
    // création du user de firebase
    final usercurrent = await _auth.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    /// creation user data firestore
    profilSchema.uid = usercurrent.user!.uid;
    profil.updateProfil(profilSchema, idProfil);
    notifyListeners();
  }

  // fonction qui déconnecte le userCurrent
  Future<void> disconnectUser() async {
    await _auth.signOut();
    profil.resetProfil();
    notifyListeners();
  }

  /// send email pour terminer l'inscription
  Future<void> sendMailForFinishAccount(String email) async {
    /// config setting envoie mail
    ActionCodeSettings action = ActionCodeSettings(
      url: UserConst.createUrlRedirectSendMail,
      handleCodeInApp: true,
    );
    /// envoie mail
    await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: action);
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
