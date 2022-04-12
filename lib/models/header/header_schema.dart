import 'package:woopear/models/menu/menu_schema.dart';

class HeaderSchema {
  String? id;
  String? libelle;
  String? brand;
  MenuSchema? menu;

  HeaderSchema({
    this.id,
    required this.libelle,
    required this.brand,
    required this.menu,
  });

  factory HeaderSchema.fromMap(Map<String, dynamic> data, documentId) {
    String fullName = data['libelle'];
    String brand = data['brand'];
    MenuSchema menu = data['menu'];

    return HeaderSchema(
      id: documentId,
      libelle: fullName,
      brand: brand,
      menu: menu,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'libelle': libelle,
      'brand': brand,
      'menu': menu,
    };
  }
}
