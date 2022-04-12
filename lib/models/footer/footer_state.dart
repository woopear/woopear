import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_state.dart';
import 'package:woopear/models/footer/footer_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class FooterState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;
  final _footerMenu = FooterMenuState();

  /// ecoute tous les footers
  Stream<List<FooterSchema>> streamFooters() {
    return _firestore.streamCol<FooterSchema>(
      path: FirestorePath.footers(),
      builder: (data, documentId) => FooterSchema.fromMap(data, documentId),
    );
  }

  /// add footer
  Future<void> addFooter(FooterSchema newFooter) async {
    await _firestore.add(
      path: FirestorePath.footers(),
      data: newFooter.toMap(),
    );
  }

  /// update footer
  Future<void> updateFooter(String idFooter, FooterSchema newFooter) async {
    await _firestore.update(
      path: FirestorePath.footer(idFooter),
      data: newFooter.toMap(),
    );
  }

  /// delete footer
  Future<void> deleteFooter(String idFooter) async {
    /// delete les menus du footer
    await _footerMenu.deleteFooterMenus(idFooter);

    /// delete footer
    await _firestore.delete(
      path: FirestorePath.footer(idFooter),
    );
  }
}

/// state de la class FooterState
final footerChange =
    ChangeNotifierProvider<FooterState>((ref) => FooterState());

/// state liste footers
final footersStream = StreamProvider((ref) {
  return ref.watch(footerChange).streamFooters();
});

/// state un footer (le premier)
final footerProvider = Provider((ref) {
  FooterSchema? list;
  ref.watch(footersStream).whenData((value) {
    list = value[0];
  });
  return list;
});
