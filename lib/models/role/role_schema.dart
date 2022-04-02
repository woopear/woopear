class RoleSchema {
  String libelle;
  String description;

  RoleSchema({required this.libelle, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'description': description,
    };
  }
}