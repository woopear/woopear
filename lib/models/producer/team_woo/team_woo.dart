class TeamWooSchema {
  String? id;
  String? title;
  String? description;

  TeamWooSchema({
    this.id,
    required this.title,
    required this.description,
  });

  factory TeamWooSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String description = data['description'];

    return TeamWooSchema(
      id: documentId,
      title: title,
      description: description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
