import 'package:woopear/models/article_condition_gene/condition_gene/condition_gene_schema.dart';

class ArticleGeneSchema {
  String? id;
  String? subTitle;
  List<ConditionGeneSchema>? conditionGene;

  ArticleGeneSchema({
    this.id,
    required this.subTitle,
    required this.conditionGene,
  });

  factory ArticleGeneSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String subTitle = data['subTitle'];
    List<ConditionGeneSchema> conditionGene = data['conditionGene'];

    return ArticleGeneSchema(
      id: documentId,
      subTitle: subTitle,
      conditionGene: conditionGene,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subTitle': subTitle,
      'conditionGene': conditionGene,
    };
  }
}
