import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ProfilState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;
  ProfilSchema? _profilCurrent;
  late Stream<List<ProfilSchema>> _profilsCurrent;

  ProfilSchema? get profilCurrent => _profilCurrent;
  Stream<List<ProfilSchema>> get profilsCurrent => _profilsCurrent;

  /// ecoute tous les profil correspondant au uid en argument
  Future<void> streamAllProfils(String uid) async {
    _profilsCurrent = _firestore.streamCol(
      path: FirestorePath.profils(),
      builder: (data, documentId) => ProfilSchema.fromMap(data, documentId),
      queryBuilder: (query) => query.where('uid', isEqualTo: uid),
    );
  }

  /// recuperation du profil par rapport à l'email que l'utilisateur
  /// va utiliser pour creer son compte il doit correspondre
  Future<ProfilSchema?> getProfilForCreateAuthForTestEmail(String email) async {
    final profil = await _firestore.getCol(
      path: FirestorePath.profils(),
      builder: (data, documentId) => ProfilSchema.fromMap(data, documentId),
      queryBuilder: (query) => query.where('email', isEqualTo: email),
    );
    return profil[0];
  }

  /// ajoute un profil
  Future<void> addProfil(ProfilSchema profil) async {
    await _firestore.add(
      path: FirestorePath.profils(),
      data: profil.toMap(),
    );
  }

  /// modifie profil
  Future<void> updateProfil(ProfilSchema profil, String idProfil) async {
    await _firestore.update(
      path: FirestorePath.profil(idProfil),
      data: profil.toMap(),
    );
  }

  /// affecte le profil recuperer
  void setProfilCurrent(ProfilSchema profil) {
    _profilCurrent = profil;
  }

  /// reset le stockage du profil du user connecté
  void resetProfil() {
    _profilCurrent = null;
  }
}

/// state de la class ProfilState
final profilChange =
    ChangeNotifierProvider<ProfilState>((ref) => ProfilState());

/// ecoute tous les profil correspondant au uid en argument
final allProfilsStream = StreamProvider((ref) {
  ref.watch(userCurrentStream).whenData((value) {
    ref.watch(profilChange).streamAllProfils(value!.uid);
  });
  return ref.watch(profilChange).profilsCurrent;
});

/// state profilCurrent en cours
final profilCurrentProvider = Provider((ref) {
  ref.watch(allProfilsStream).whenData((value) {
    ref.watch(profilChange).setProfilCurrent(value[0]);
  });
  return ref.watch(profilChange).profilCurrent;
});
