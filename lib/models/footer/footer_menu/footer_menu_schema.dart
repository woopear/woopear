class FooterMenuSchema {
  String? id;
  String libelle;
  String url;

  FooterMenuSchema({
    this.id,
    required this.libelle,
    required this.url,
  });

  factory FooterMenuSchema.fromMap(Map<String, dynamic> data, documentId) {
    String libelle = data['libelle'];
    String url = data['url'];

    return FooterMenuSchema(
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
