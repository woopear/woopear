import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ConditionGeneState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;
  final _article = ConditionGeneArticleState();

  /// ecouteur de tous les condition gene
  Stream<List<ConditionGeneSchema>> streamConditionGenes() {
    return _firestore.streamCol<ConditionGeneSchema>(
      path: FirestorePath.conditionGenes(),
      builder: (data, documentId) =>
          ConditionGeneSchema.fromMap(data, documentId),
    );
  }

  /// ecouteur de une condition gene
  Stream<ConditionGeneSchema> streamConditionGene(String idConditionGene) {
    return _firestore.streamDoc<ConditionGeneSchema>(
      path: FirestorePath.conditionGene(idConditionGene),
      builder: (data, documentId) =>
          ConditionGeneSchema.fromMap(data, documentId),
    );
  }

  /// add condition gene
  Future<void> addConditionGene(ConditionGeneSchema newConditionGene) async {
    await _firestore.add(
      path: FirestorePath.conditionGenes(),
      data: newConditionGene.toMap(),
    );
  }

  /// update condition gene
  Future<void> updateConditionGene(
      String idConditionGene, ConditionGeneSchema newConditionGene) async {
    await _firestore.update(
      path: FirestorePath.conditionGene(idConditionGene),
      data: newConditionGene.toMap(),
    );
  }

  /// delete condition gene
  Future<void> deleteConditionGene(String idConditionGene) async {
    /// delete tous les articles
    await _article.deleteArticlesOfConditionGene(idConditionGene);

    /// delete condition gene
    await _firestore.delete(
      path: FirestorePath.conditionGene(idConditionGene),
    );
  }
}

/// state de ma class ConditionGeneState
final conditionGeneChange =
    ChangeNotifierProvider<ConditionGeneState>((ref) => ConditionGeneState());

/// sate du stream de toutes les condition gene
final conditionGenesStream = StreamProvider((ref) {
  return ref.watch(conditionGeneChange).streamConditionGenes();
});

/// state du stream d'une condition gene
final conditionGeneStream =
    StreamProvider.family((ref, String idConditionGene) {
  return ref.watch(conditionGeneChange).streamConditionGene(idConditionGene);
});

/// state d'une condition gene
final conditionGeneSelectedProvider =
    Provider.family((ref, String idConditionGene) {
  ConditionGeneSchema? conditionGene;
  ref.watch(conditionGeneStream(idConditionGene)).whenData((value) {
    conditionGene = value;
  });
  return conditionGene;
});
