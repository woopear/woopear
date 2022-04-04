import 'package:woopear/models/advertising/advertising_schema.dart';


class ArticleAdversSchema {
  String? id;
  String? sub_title;
  AdvertisingSchema advertising;

  ArticleAdversSchema({
    this.id,
    required this.sub_title,
    required this.advertising,
  });

  factory ArticleAdversSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String subTitle = data['sub_title'];
    AdvertisingSchema advertising = data['advertising'];

    return ArticleAdversSchema(
      id: documentId,
      sub_title: subTitle,
      advertising: advertising,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sub_title': sub_title,
      'advertising': advertising,
    };
  }
}
