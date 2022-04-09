import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/presentation/presentation_content/presentation_content_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class PresentationContentState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;

  Stream<List<PresentationContentSchema>>? _contentsOfPresentationUpdate;
  Stream<List<PresentationContentSchema>>? get contentsOfPresentationUpdate =>
      _contentsOfPresentationUpdate;

  /// ecouteur content d'une présentation
  Stream<void>? streamContentOfPresentation(String idPresentation) {
    _contentsOfPresentationUpdate = _firestore.streamCol(
      path: FirestorePath.presentationContents(idPresentation),
      builder: (data, documentId) =>
          PresentationContentSchema.fromMap(data, documentId),
    );
    return null;
  }

  /// ajouter un content de la présentation
  Future<void> addContentOfPresentation(
      String idPresentation, PresentationContentSchema newContent) async {
    await _firestore.add(
      path: FirestorePath.presentationContents(idPresentation),
      data: newContent.toMap(),
    );
  }

/// modification du content de la présentation
  Future<void> updateContentOfPresentation(
      String idPresentation, String idContent, PresentationContentSchema newContent) async {
    await _firestore.update(
      path: FirestorePath.presentationContent(idPresentation, idContent),
      data: newContent.toMap(),
    );
  }

  /// delete content de la présentation
  Future<void> deleteContentOfPresentation(
      String idPresentation, String idContent) async {
    await _firestore.delete(
      path: FirestorePath.presentationContent(idPresentation, idContent),
    );
  }
}

/// state de la class presentationCOntentState
final presentationContentChange =
    ChangeNotifierProvider<PresentationContentState>(
        (ref) => PresentationContentState());

/// state tous les contents d'une présentation
final contentsOfPresentationStream =
    StreamProvider.autoDispose.family((ref, String idPresentation) {
  ref
      .watch(presentationContentChange)
      .streamContentOfPresentation(idPresentation);
  return ref.watch(presentationContentChange).contentsOfPresentationUpdate!;
});
