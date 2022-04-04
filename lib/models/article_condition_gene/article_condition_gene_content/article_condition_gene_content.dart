import 'package:woopear/models/article_condition_gene/article_condition_gene.dart';
import 'package:woopear/models/content/content_schema.dart';

class ArticleGeneContentSchema {
  String? id;
  ArticleGeneSchema? articleGene;
  ContentSchema? content;

  ArticleGeneContentSchema({
    this.id,
    required this.articleGene,
    required this.content,
  });

  factory ArticleGeneContentSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    ArticleGeneSchema subTitle = data['articleGene'];
    ContentSchema content = data['content'];

    return ArticleGeneContentSchema(
      id: documentId,
      articleGene: subTitle,
      content: content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'articleGene': articleGene,
      'content': content,
    };
  }
}
