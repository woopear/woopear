import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/config/routes.dart';

class AppBarBasic extends ConsumerStatefulWidget with PreferredSizeWidget {
  String text;
  bool automaticallyImplyLeading;
  bool seeConnexion;

  AppBarBasic(
      {Key? key,
      required this.text,
      required this.automaticallyImplyLeading,
      required this.seeConnexion})
      : super(key: key);

  @override
  _AppBarFlutooState createState() => _AppBarFlutooState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarFlutooState extends ConsumerState<AppBarBasic> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AppBar(
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: Text(widget.text),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              widget.seeConnexion
                  ? user != null
                      ? Row(
                          children: [
                            /// icon goto tableau de bord
                            /// seulement visible si il est sur la page du site
                            widget.text != 'Woopear'
                                ? Container()
                                : IconButton(
                                    tooltip: 'Retour tableau de bord',
                                    onPressed: () async {
                                      Navigator.pushNamed(
                                          context, Routes().appAcces);
                                    },
                                    icon: const Icon(Icons.dashboard_rounded),
                                  ),

                            /// icon deconnection
                            IconButton(
                              onPressed: () async {
                                await ref.watch(userChange).disconnectUser();
                                Navigator.pop(context, true);
                              },
                              icon: const Icon(Icons.logout),
                            ),
                          ],
                        )

                      /// icon connexion
                      : IconButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, Routes().appAcces);
                          },
                          icon: const Icon(Icons.person_rounded),
                        )
                  : Container(),

              ///switch mode dark
              const WooThemeSwitch(
                iconFalse: Icon(Icons.dark_mode_outlined),
                iconTrue: Icon(Icons.light_mode_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
