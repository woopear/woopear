import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ProfilState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;
  ProfilSchema? _profil;

  ProfilSchema? get profil => _profil;

  /// ajoute un profil
  Future<void> addProfil(ProfilSchema profil) async {
    await _firestore.add(
      path: FirestorePath.profils(),
      data: profil.toMap(),
    );
  }

  /// reset le stockage du profil du user connecté
  void resetProfil() {
    _profil = null;
  }
}

/// state de la class ProfilState
final ProfilChange =
    ChangeNotifierProvider<ProfilState>((ref) => ProfilState());
