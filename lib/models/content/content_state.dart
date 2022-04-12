import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/content/content_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ContentState extends ChangeNotifier {
  /// variables
  final WooFirestore _firebaseService = WooFirestore.instance;
  late Stream<ContentSchema> _contents;
  ContentSchema? _content;

  Stream<ContentSchema> get contents => _contents;
  ContentSchema? get content => _content;

  /// ecouteur du content
  Stream<void>? streamContentById(String idContent) {
    _contents = _firebaseService.streamDoc(
      path: FirestorePath.content(idContent),
      builder: (data, documentId) => ContentSchema.fromMap(data, documentId),
    );
    return null;
  }

  void setContent(ContentSchema contentSchema) {
    _content = contentSchema;
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

final contentAllStream = StreamProvider((ref) {
  return ref.watch(contentChange).contents;
});

final contentStreamById = Provider.family((ref, String idContent) {
  ref.watch(contentChange).streamContentById(idContent);
  ref.watch(contentAllStream).whenData((value) {
    ref.watch(contentChange).setContent(value);
  });
  return ref.watch(contentChange).content;
});
