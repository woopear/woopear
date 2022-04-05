import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/content/content_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ContentState extends ChangeNotifier {
  /// variables
  final WooFirestore _firebaseService = WooFirestore.instance;
  late Stream<List<ContentSchema>> _content;

  Stream<List<ContentSchema?>?>? get content => _content;

  /// ecouteur du content
  Future<void> streamContentById(String idContent) async {
    _content = _firebaseService.streamCol(
      path: FirestorePath.content(idContent),
      builder: (data, documentId) => ContentSchema.fromMap(data, documentId),
      queryBuilder: (query) => query.where('id', isEqualTo: idContent),
    );
  }

  /// ajouter un content
  Future<void> addContent(ContentSchema content) async {
    await _firebaseService.add(
      path: FirestorePath.contents(),
      data: content.toMap(),
    );
  }

  /// modifier un content
  Future<void> updateContent(ContentSchema content, String idContent) async {
    await _firebaseService.update(
      path: FirestorePath.content(idContent),
      data: content.toMap(),
    );
  }

  /// supprimer un content
  Future<void> deleteContent(String idContent) async {
    await _firebaseService.delete(
      path: FirestorePath.content(idContent),
    );
  }
}

/// state de la class ContentState
final contentChange =
    ChangeNotifierProvider<ContentState>((ref) => ContentState());

/* /// state du content
final contentStream = StreamProvider<void>((ref) {
  ref.watch(contentChange).streamContentById(idContent);
  return ref.watch(contentChange)._content;
}); */
