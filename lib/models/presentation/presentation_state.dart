import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class PresentationState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;

  /// variable de toutes les prĂ©sentations
  Stream<List<PresentationSchema>>? _presentations;
  Stream<List<PresentationSchema>>? get presentations => _presentations;

  Stream<PresentationSchema>? _presentationSelectForUpdate;
  Stream<PresentationSchema>? get presentationSelectForUpdate =>
      _presentationSelectForUpdate;

  Stream<PresentationSchema>? _presentationSelect;
  Stream<PresentationSchema>? get presentationSelect => _presentationSelect;

  /// ecoute toutes les presentations
  Stream<void>? streamPresentations() {
    _presentations = _firestore.streamCol(
      path: FirestorePath.presentations(),
      builder: (data, documentId) =>
          PresentationSchema.formMap(data, documentId),
    );
    return null;
  }

  /// ecoute une presentation pour modification
  Stream<void>? streamPresentationUpdate(String idPresentation) {
    _presentationSelectForUpdate = _firestore.streamDoc(
      path: FirestorePath.presentation(idPresentation),
      builder: (data, documentId) =>
          PresentationSchema.formMap(data, documentId),
    );
    return null;
  }

  /// ecoute une presentation pour affichage page d'accueil
  Stream<void>? streamPresentationSelect(String idPresentation) {
    _presentationSelect = _firestore.streamDoc(
      path: FirestorePath.presentation(idPresentation),
      builder: (data, documentId) =>
          PresentationSchema.formMap(data, documentId),
    );
    return null;
  }

  /// creer une presentation
  Future<void> createPresentation(PresentationSchema newPresentation) async {
    await _firestore.add(
      path: FirestorePath.presentations(),
      data: newPresentation.toMap(),
    );
  }

  /// update presentation
  Future<void> updatePresentation(PresentationSchema newPresentation) async {
    await _firestore.update(
      path: FirestorePath.presentation(newPresentation.id!),
      data: newPresentation.toMap(),
    );
  }

  /// delete prĂ©sentation
  Future<void> deletePresentation(String idPresentation) async {
    await _firestore.delete(
      path: FirestorePath.presentation(idPresentation),
    );
  }
}

/// state de la class presentationState
final presentationChange =
    ChangeNotifierProvider<PresentationState>((ref) => PresentationState());

/// state de toute les prĂ©sentation
final allPresentationStream = StreamProvider((ref) {
  ref.watch(presentationChange).streamPresentations();
  return ref.watch(presentationChange).presentations!;
});

/// state de la liste des presentations
final presentationsProvider = Provider<List<PresentationSchema>?>((ref) {
  List<PresentationSchema>? list;
  ref.watch(allPresentationStream).whenData((value) {
    list = value;
  });
  return list;
});

/// state presentation selectionnĂ© pour update
final presentationUpdateStream = StreamProvider((ref) {
  return ref.watch(presentationChange).presentationSelectForUpdate!;
});

/// state presentation selectionnĂ© pour affichage page d'accueil
final presentationSelectProvider = Provider<PresentationSchema?>((ref) {
  PresentationSchema? presentation;
  ref.watch(allPresentationStream).whenData((value) {
    presentation = value[0];
  });
  return presentation;
});
