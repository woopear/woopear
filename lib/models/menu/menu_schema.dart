class MenuSchema {
  String? id;
  String? libelle;

  MenuSchema({
    this.id,
    required this.libelle,
  });

  factory MenuSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String libelle = data['libelle'];

    return MenuSchema(
      id: documentId,
      libelle: libelle,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
    };
  }
}
