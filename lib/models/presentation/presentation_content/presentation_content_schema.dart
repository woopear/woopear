class PresentationContentSchema {
  String? id;
  String text;
  String? subTitle;

  PresentationContentSchema({
    this.id,
    required this.text,
    this.subTitle,
  });

  factory PresentationContentSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String text = data['content'];
    String subTitle = data['subTitle'] ?? '';

    return PresentationContentSchema(
      id: documentId,
      text: text,
      subTitle: subTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'subTitle': subTitle,
    };
  }
}
