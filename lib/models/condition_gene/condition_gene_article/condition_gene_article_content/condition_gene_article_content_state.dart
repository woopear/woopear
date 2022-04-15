import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:woo_firestore_crud/woo_firestore_crud.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_schema.dart';
import 'package:woopear/utils/fire/firestore_path.dart';

class ConditionGeneArticleContentState extends ChangeNotifier {
  final _firestore = WooFirestore.instance;

  /// ecoute tous les contents d'un article d'une condition
  Stream<List<ConditionGeneArticleContentSchema>>
      streamContentsOfArticleOfConditionGene(
    String idConditionGene,
    String idArticle,
  ) {
    return _firestore.streamCol(
      path: FirestorePath.conditionGeneArticleContents(
          idConditionGene, idArticle),
      builder: (data, documentId) =>
          ConditionGeneArticleContentSchema.fromMap(data, documentId),
    );
  }

  /// add un content
  Future<void> addContentOfArticleOfConditionGene(
    String idConditionGene,
    String idArticle,
    ConditionGeneArticleContentSchema newContent,
  ) async {
    await _firestore.add(
      path: FirestorePath.conditionGeneArticleContents(
          idConditionGene, idArticle),
      data: newContent.toMap(),
    );
  }

  /// update un content
  Future<void> updateContentOfArticleOfConditionGene(
    String idConditionGene,
    String idArticle,
    String idContent,
    ConditionGeneArticleContentSchema newContent,
  ) async {
    await _firestore.update(
      path: FirestorePath.conditionGeneArticleContent(
          idConditionGene, idArticle, idContent),
      data: newContent.toMap(),
    );
  }

  /// delete un content
  Future<void> deleteContentOfArticleOfConditionGene(
    String idConditionGene,
    String idArticle,
    String idContent,
  ) async {
    await _firestore.delete(
      path: FirestorePath.conditionGeneArticleContent(
        idConditionGene,
        idArticle,
        idContent,
      ),
    );
  }

  /// delete tous les content d'un article d'une condition
  Future<void> deleteContentsOfArticleOfConditionGene(
    String idConditionGene,
    String idArticle,
  ) async {
    /// instance firestore pour batch
    WriteBatch batch = FirebaseFirestore.instance.batch();

    /// ref collection path
    CollectionReference ref = FirebaseFirestore.instance.collection(
      FirestorePath.conditionGeneArticleContents(idConditionGene, idArticle),
    );

    /// boucle pour delete les articles
    return ref.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      notifyListeners();
      return batch.commit();
    });
  }
}

/// state de la class conditiongenearticlecontentstate
final conditionGeneArticleContentChange =
    ChangeNotifierProvider<ConditionGeneArticleContentState>(
        (ref) => ConditionGeneArticleContentState());

/// state de tous les contents d'un article
final contentsOfArticleStream =
    StreamProvider.family((ref, Tuple2<String, String> ids) {
  return ref
      .watch(conditionGeneArticleContentChange)
      .streamContentsOfArticleOfConditionGene(ids.item1, ids.item2);
});
