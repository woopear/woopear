class CompanieSchema {
  String codeNaf;
  String siret;
  String denomination;
  String? address;
  String? codePost;
  String? city;
  String? logo;

  CompanieSchema({
    required this.codeNaf,
    required this.siret,
    required this.denomination,
    this.address,
    this.codePost,
    this.city,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'codeNaf': codeNaf,
      'siret': siret,
      'denomination': denomination,
      'address': address ?? '',
      'codePost': codePost ?? '',
      'city': city ?? '',
      'logo': logo ?? '',
    };
  }
}
