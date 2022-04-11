import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/upload/upload_state.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ProfilState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;
  ProfilSchema? _profilCurrent;
  late Stream<List<ProfilSchema>> _profilsCurrent;
  late Stream<List<ProfilSchema>> _profils;
  final UploadFile _upload = UploadFile();

  ProfilSchema? get profilCurrent => _profilCurrent;
  Stream<List<ProfilSchema>> get profilsCurrent => _profilsCurrent;
  Stream<List<ProfilSchema?>?>? get profils => _profils;

  /// ecoute tous les profil utilisateur
  Future<void> streamAllProfils() async {
    _profils = _firestore.streamCol(
      path: FirestorePath.profils(),
      builder: (data, documentId) => ProfilSchema.fromMap(data, documentId),
    );
  }

  /// ecoute tous les profil correspondant au uid en argument
  Future<void> streamAllProfilsCurrent(String uid) async {
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

  /// suppression profil
  Future<void> deleteProfil(String uid, String idProfil) async {
    await _firestore.delete(
      path: FirestorePath.profil(idProfil),
    );

    /// faire passé uid pour supprimer image avatar
    await _upload.deleteImage('avatars/user-$uid');
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

/// stream ecoute tout les profils
final allProfilsStream = StreamProvider<List<ProfilSchema?>?>((ref) {
  ref.watch(profilChange).streamAllProfils();
  return ref.watch(profilChange).profils!;
});

/// ecoute tous les profil correspondant au uid en argument
final allProfilsCurrentStream = StreamProvider((ref) {
  ref.watch(userCurrentStream).whenData((value) {
    ref.watch(profilChange).streamAllProfilsCurrent(value!.uid);
  });
  return ref.watch(profilChange).profilsCurrent;
});

/// state profilCurrent en cours
final profilCurrentProvider = Provider((ref) {
  ref.watch(allProfilsCurrentStream).whenData((value) {
    ref.watch(profilChange).setProfilCurrent(value[0]);
  });
  return ref.watch(profilChange).profilCurrent;
});

/// state allprofil
final allProfilProvider = Provider((ref) {
  List<ProfilSchema?>? listProfil;
  ref.watch(allProfilsStream).whenData((value) {
    listProfil = value;
  });
  return listProfil;
});
