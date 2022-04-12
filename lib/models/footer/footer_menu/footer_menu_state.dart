import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class FooterMenuState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute tous les FooterMenu d'un footer
  Stream? streamFooterMenus(String idFooter) {
    _firestore.streamCol(
      path: FirestorePath.footerMenus(idFooter),
      builder: (data, documentId) => FooterMenuSchema.fromMap(data, documentId),
    );
    return null;
  }

  /// add FooterMenu
  Future<void> addFooterMenu(
      String idFooter, FooterMenuSchema newFooterMenu) async {
    await _firestore.add(
      path: FirestorePath.footerMenus(idFooter),
      data: newFooterMenu.toMap(),
    );
    notifyListeners();
  }

  /// update FooterMenu
  Future<void> updateFooterMenu(String idFooter, String idFooterMenu,
      FooterMenuSchema newFooterMenu) async {
    await _firestore.update(
      path: FirestorePath.footerMenu(idFooter, idFooterMenu),
      data: newFooterMenu.toMap(),
    );
    notifyListeners();
  }

  /// delete un FooterMenu
  Future<void> deleteFooterMenu(String idFooter, String idFooterMenu) async {
    await _firestore.delete(
      path: FirestorePath.footerMenu(idFooter, idFooterMenu),
    );
    notifyListeners();
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
    return ref.get().then((querySnapshot){
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }
}
