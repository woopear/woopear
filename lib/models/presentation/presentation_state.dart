import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class PresentationState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;

  /// variable de toutes les présentations
  Stream<List<PresentationSchema>>? _presentations;
  Stream<List<PresentationSchema>>? get presentations => _presentations;

  /// ecoute toutes les presentations
  Stream<void>? streamPresentations() {
    _presentations = _firestore.streamCol(
      path: FirestorePath.presentations(),
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
}

/// state de la class presentationState
final presentationChange =
    ChangeNotifierProvider<PresentationState>((ref) => PresentationState());

/// state de toute les présentation
final allPresentationStream = StreamProvider((ref) {
  ref.watch(presentationChange).streamPresentations();
  return ref.watch(presentationChange).presentations!;
});
