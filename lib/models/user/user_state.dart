import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';

class UserState extends ChangeNotifier {
  final FirebaseAuth _user = FirebaseAuth.instance;
  final ProfilState profil = PrifilState();

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
  Future<void> createUser(TextEditingController email,
      TextEditingController password, ProfilSchema profilSchema) async {
    // création du user de firebase
    final usercurrent = await _user.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    /// creation user data firestore
    profilSchema.uid = usercurrent.user!.uid;
    profil.addProfil(profilSchema);
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

final userState = ChangeNotifierProvider<UserState>((ref) => UserState());

