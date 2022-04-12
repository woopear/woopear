import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class FooterMenuState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute tous les FooterMenu d'un footer
  Stream<List<FooterMenuSchema>> streamFooterMenus(String idFooter) {
    return _firestore.streamCol<FooterMenuSchema>(
      path: FirestorePath.footerMenus(idFooter),
      builder: (data, documentId) => FooterMenuSchema.fromMap(data, documentId),
    );
  }

  /// add FooterMenu
  Future<void> addFooterMenu(
      String idFooter, FooterMenuSchema newFooterMenu) async {
    await _firestore.add(
      path: FirestorePath.footerMenus(idFooter),
      data: newFooterMenu.toMap(),
    );
  }

  /// update FooterMenu
  Future<void> updateFooterMenu(String idFooter, String idFooterMenu,
      FooterMenuSchema newFooterMenu) async {
    await _firestore.update(
      path: FirestorePath.footerMenu(idFooter, idFooterMenu),
      data: newFooterMenu.toMap(),
    );
  }

  /// delete un FooterMenu
  Future<void> deleteFooterMenu(String idFooter, String idFooterMenu) async {
    await _firestore.delete(
      path: FirestorePath.footerMenu(idFooter, idFooterMenu),
    );
  }

  /// delete plusieurs FooterMenu
  Future<void> deleteFooterMenus(String idFooter) async {
    /// instance firestore pour batch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref collection path
    CollectionReference ref = FirebaseFirestore.instance.collection(
      FirestorePath.footerMenus(idFooter),
    );

    /// boucle pour delete FooterMenu
    return ref.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }
}

/// state de la class FooterMenu
final footerMenuChange =
    ChangeNotifierProvider<FooterMenuState>((ref) => FooterMenuState());

/// state list des menus d'un footer
final footerMenusStream =
    StreamProvider.autoDispose.family((ref, String idFooter) {
  return ref.watch(footerMenuChange).streamFooterMenus(idFooter);
});
