class LinkSchema {
  String? id;
  String? libelle;
  String? url;

  LinkSchema({
    this.id,
    required this.libelle,
    required this.url,
  });

  factory LinkSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    String libelle = data['libelle'];
    String url = data['url'];

    return LinkSchema(
      id: documentId,
      libelle: libelle,
      url: url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'url': url,
    };
  }
}
