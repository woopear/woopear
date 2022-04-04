import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ProfilState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;
  ProfilSchema? _profilCurrent;

  ProfilSchema? get profilCurrent => _profilCurrent;

  /// recuperation du profil par rapport à l'email que l'utilisateur
  /// va utiliser pour creer son compte il doit correspondre
  Future<ProfilSchema?> getProfilForCreateAuthForTestEmail(String email) async {
    final profil = await _firestore.getCol(
      path: FirestorePath.profils(),
      builder: (data, documentId) => ProfilSchema.fromMap(data, documentId),
      queryBuilder: (query) => query.where('email', isEqualTo: email),
    );
    if (profil == null) {
      return null;
    }
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

  /// reset le stockage du profil du user connecté
  void resetProfil() {
    _profilCurrent = null;
  }
}

/// state de la class ProfilState
final ProfilChange =
    ChangeNotifierProvider<ProfilState>((ref) => ProfilState());
