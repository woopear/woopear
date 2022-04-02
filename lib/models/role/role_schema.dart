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

List<RoleSchema> rolesBase = [
  RoleSchema(
      libelle: 'public', description: 'utilisateur avec le minimum de droit'),
  RoleSchema(libelle: 'root', description: 'utilisateur créateur du site'),
  RoleSchema(libelle: 'auth', description: 'utilisateur authentifier'),
];
