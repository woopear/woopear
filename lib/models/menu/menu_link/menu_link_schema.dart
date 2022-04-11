import 'package:woopear/models/menu/menu_schema.dart';
import 'package:woopear/models/menu/menu_link/link/link_schema.dart';

class MenuLinkSchema {
  String? id;
  MenuSchema? menu;
  LinkSchema? link;

  MenuLinkSchema({
    this.id,
    required this.menu,
    required this.link,
  });

  factory MenuLinkSchema.fromMap(
      Map<String, dynamic> data, documentId) {
    MenuSchema menu = data['menu'];
    LinkSchema link = data['link'];

    return MenuLinkSchema(
      id: documentId,
      menu: menu,
      link: link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menu': menu,
      'link': link,
    };
  }
}
