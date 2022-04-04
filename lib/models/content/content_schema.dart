class ContentSchema {
  String? id;
  String? subTitle;
  String? content;

  ContentSchema({
    this.id,
    required this.subTitle,
    required this.content,
  });

  factory ContentSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String subTitle = data['subTitle'];
    String content = data['content'];

    return ContentSchema(
      id: documentId,
      subTitle: subTitle,
      content: content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subTitle': subTitle,
      'content': content,
    };
  }
}
