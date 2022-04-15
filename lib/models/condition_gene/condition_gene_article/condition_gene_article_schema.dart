class ConditionGeneArticleSchema {
  String? id;
  String title;

  ConditionGeneArticleSchema({
    this.id,
    required this.title,
  });

  factory ConditionGeneArticleSchema.formMap(data, documentId) {
    String title = data['title'];

    return ConditionGeneArticleSchema(
      id: documentId,
      title: title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
    };
  }
}
