import 'package:flutter/material.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_state.dart';
import 'package:woopear/models/footer/footer_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class FooterState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;
  final _footerMenu = FooterMenuState();

  /// ecoute tous les footers
  Stream? streamFooters() {
    _firestore.streamCol(
      path: FirestorePath.footers(),
      builder: (data, documentId) => FooterSchema.fromMap(data, documentId),
    );
    return null;
  }

  /// add footer
  Future<void> addFooter(FooterSchema newFooter) async {
    await _firestore.add(
      path: FirestorePath.footers(),
      data: newFooter.toMap(),
    );
    notifyListeners();
  }

  /// update footer
  Future<void> updateFooter(String idFooter, FooterSchema newFooter) async {
    await _firestore.update(
      path: FirestorePath.footer(idFooter),
      data: newFooter.toMap(),
    );
    notifyListeners();
  }

  /// delete footer
  Future<void> deleteFooter(String idFooter) async {
    /// delete les menus du footer
    await _footerMenu.deleteFooterMenus(idFooter);

    /// delete footer
    await _firestore.delete(
      path: FirestorePath.footer(idFooter),
    );
    notifyListeners();
  }
}
