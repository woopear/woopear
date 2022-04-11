class ConditionGeneSchema {
  String? id;
  String? title;

  ConditionGeneSchema({
    this.id,
    required this.title,
  });

  factory ConditionGeneSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String title = data['title'];

    return ConditionGeneSchema(
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
