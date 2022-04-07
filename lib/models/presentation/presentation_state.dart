import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class PresentationState extends ChangeNotifier {
  final WooFirestore _firestore = WooFirestore.instance;

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
