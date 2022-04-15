class ConditionGeneArticleContentSchema {
  String? id;
  String? subTitle;
  String text;

  ConditionGeneArticleContentSchema({
    this.id,
    this.subTitle,
    required this.text,
  });

  factory ConditionGeneArticleContentSchema.fromMap(data, documentId) {
    String subTitle = data['subTitle'] ?? '';
    String text = data['text'];

    return ConditionGeneArticleContentSchema(
      id: documentId,
      subTitle: subTitle,
      text: text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subTitle': subTitle ?? '',
      'text': text,
    };
  }
}
