import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ConditionGeneArticleState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute tous les articles d'une conditions
  Stream<List<ConditionGeneArticleSchema>> streamArticlesOfConditionGene(
      String idConditionGene) {
    return _firestore.streamCol(
      path: FirestorePath.conditionGeneArticles(idConditionGene),
      builder: (data, documentId) =>
          ConditionGeneArticleSchema.formMap(data, documentId),
    );
  }

  /// add un article d'une condition
  Future<void> addArticleOfConditionGene(
      String idConditionGene, ConditionGeneArticleSchema newArticle) async {
    await _firestore.add(
      path: FirestorePath.conditionGeneArticles(idConditionGene),
      data: newArticle.toMap(),
    );
  }

  /// update un article d'une condition
  Future<void> updateArticleOfConditionGene(String idConditionGene,
      String idArticle, ConditionGeneArticleSchema newArticle) async {
    await _firestore.update(
      path: FirestorePath.conditionGeneArticle(idConditionGene, idArticle),
      data: newArticle.toMap(),
    );
  }

  /// delete un article d'une condition
  Future<void> deleteArticleOfConditionGene(
      String idConditionGene, String idArticle) async {
    /// TODO : delete tous les contents de l'article

    await _firestore.delete(
      path: FirestorePath.conditionGeneArticle(idConditionGene, idArticle),
    );
  }

  /// delete tous les articles d'une condition
  Future<void> deleteArticlesOfConditionGene(String idConditionGene) async {
    /// instance firestore pour batch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref collection path
    CollectionReference ref = FirebaseFirestore.instance.collection(
      FirestorePath.conditionGeneArticles(idConditionGene),
    );

    /// boucle pour delete les articles
    return ref.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        /// TODO : delete tous les contents de l'article
        /// ! faire boucle

        batch.delete(doc.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }
}

/// state de la class ConditionGeneArticleState
final conditionGeneArticleChange =
    ChangeNotifierProvider<ConditionGeneArticleState>(
        (ref) => ConditionGeneArticleState());

/// state stream de tous les articles d'une condition
final articlesOfConditionGeneStream =
    StreamProvider.family((ref, String idConditionGene) {
  return ref
      .watch(conditionGeneArticleChange)
      .streamArticlesOfConditionGene(idConditionGene);
});

/// state provider de tous les articles d'une condition
final articlesOfConditionGeneProvider =
    Provider.family((ref, String idConditionGene) {
  List<ConditionGeneArticleSchema>? list;
  ref.watch(articlesOfConditionGeneStream(idConditionGene)).whenData((value) {
    list = value;
  });
  return list;
});
