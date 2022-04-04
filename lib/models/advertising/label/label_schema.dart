class LabelSchema {
  String? id;
  String? libelle;
  String? description;

  LabelSchema({
    this.id,
    required this.libelle,
    required this.description,
  });

  factory LabelSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String libelle = data['libelle'];
    String description = data['description'];

    return LabelSchema(
      id: documentId,
      libelle: libelle,
      description: description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'description': description,
    };
  }
}
