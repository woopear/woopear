import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/utils/config/routes.dart';

class DrawerBasic extends ConsumerStatefulWidget {
  const DrawerBasic({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerBasicState();
}

class _DrawerBasicState extends ConsumerState<DrawerBasic> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: ListView(
          padding: const EdgeInsets.only(left: 20.0),
          children: [
            Container(
              height: 50.0,
            ),

            /// home
            ItemMenu(
              text: 'Tableau de bord',
              icon: Icons.home_rounded,
              colorIcon: Colors.white,
              colorText: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, Routes().appAcces);
              },
            ),

            /// client
            ItemMenu(
              text: 'Clients',
              icon: Icons.people,
              colorIcon: Colors.white,
              colorText: Colors.white,
              onTap: () {},
            ),

            /// separation avec info compte
            SeparateItem(
              heighTop: 20.0,
              heighBottom: 20.0,
              colorSeparate: Colors.white60,
            ),

            /// mon compte
            ItemMenu(
              text: 'Mon compte',
              icon: Icons.account_circle_rounded,
              colorIcon: Colors.white,
              colorText: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, Routes().account);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// les diffentes item de menu
  Widget ItemMenu(
      {required String text,
      required IconData icon,
      required Color colorIcon,
      required Color colorText,
      void Function()? onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: colorIcon,
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 18.0, color: colorText),
      ),
      hoverColor: Colors.white10,
      onTap: onTap,
    );
  }

  /// petit séparateur sous forme de trait
  Widget SeparateItem({
    required double heighTop,
    required double heighBottom,
    required Color colorSeparate,
  }) {
    return Container(
      margin: EdgeInsets.only(top: heighTop, bottom: heighBottom),
      child: Divider(
        color: colorSeparate,
      ),
    );
  }
}
