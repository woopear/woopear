import 'package:woopear/models/presentation/presentation_schema.dart';

class PresentationContentSchema {
  String? id;
  String? content;
  PresentationSchema? presentation;

  PresentationContentSchema({
    this.id,
    required this.content,
    required this.presentation,
  });

  factory PresentationContentSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String content = data['content'];
    PresentationSchema presentation = data['presentation'];

    return PresentationContentSchema(
      id: documentId,
      content: content,
      presentation: presentation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'presentation': presentation,
    };
  }
}
