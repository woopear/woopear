import 'package:woopear/models/menu/menu.dart';

class FooterSchema {
  String? id;
  String? libelle;
  String? brand;
  String? description;
  String? copyright;
  MenuSchema? menu;

  FooterSchema({
    this.id,
    required this.libelle,
    required this.brand,
    required this.description,
    this.copyright,
    required this.menu,
  });

  factory FooterSchema.fromMap(Map<String, dynamic> data, documentId) {
    String fullName = data['libelle'];
    String brand = data['brand'];
    String description = data['description'];
    String copyright = data['copyright'] ?? '';
    MenuSchema menu = data['menu'];

    return FooterSchema(
      id: documentId,
      libelle: fullName,
      brand: brand,
      description: description,
      copyright: copyright,
      menu: menu,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'brand': brand,
      'description': description,
      'copyright': copyright ?? '',
      'menu': menu,
    };
  }
}
