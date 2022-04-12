import 'package:woopear/models/advertising/article_advers/article_advers_schema.dart';
import 'package:woopear/models/content/content_schema.dart';

class ArticleAdversContentSchema {
  String? id;
  ArticleAdversSchema? articleAdvers;
  ContentSchema? content;

  ArticleAdversContentSchema({
    this.id,
    required this.articleAdvers,
    required this.content,
  });

  factory ArticleAdversContentSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    ArticleAdversSchema articleAdvers = data['articleAdvers'];
    ContentSchema content = data['content'];

    return ArticleAdversContentSchema(
      id: documentId,
      articleAdvers: articleAdvers,
      content: content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'articleAdvers': articleAdvers,
      'content': content,
    };
  }
}
