import 'package:woopear/models/article_condition_gene/condition_gene/condition_gene.dart';

class ArticleGeneSchema {
  String? id;
  String? sub_title;
  ConditionGeneSchema? conditionGene;

  ArticleGeneSchema({
    this.id,
    required this.sub_title,
    required this.conditionGene,
  });

  factory ArticleGeneSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String subTitle = data['sub_title'];
    ConditionGeneSchema conditionGene = data['conditionGene'];

    return ArticleGeneSchema(
      id: documentId,
      sub_title: subTitle,
      conditionGene: conditionGene,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sub_title': sub_title,
      'conditionGene': conditionGene,
    };
  }
}
