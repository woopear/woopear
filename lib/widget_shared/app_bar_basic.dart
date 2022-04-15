import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/utils/config/routes.dart';

class AppBarBasic extends ConsumerStatefulWidget with PreferredSizeWidget {
  String text;
  bool automaticallyImplyLeading;
  bool seeConnexion;
  bool seeMenuProfil;

  AppBarBasic({
    Key? key,
    required this.text,
    required this.automaticallyImplyLeading,
    required this.seeConnexion,
    this.seeMenuProfil = false,
  }) : super(key: key);

  @override
  _AppBarFlutooState createState() => _AppBarFlutooState();

  @override
  Size get preferredSize =>
      Size.fromHeight(seeMenuProfil ? 180.0 : kToolbarHeight);
}

class _AppBarFlutooState extends ConsumerState<AppBarBasic> {
  @override
  Widget build(BuildContext context) {
    /// on ecouteur user connecter
    final user = FirebaseAuth.instance.currentUser;

    /// recuperer list user avec role root
    final allProfil = ref.watch(allProfilProvider);

    return AppBar(
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: Text(widget.text),
      centerTitle: true,
      toolbarTextStyle: GoogleFonts.nunito(),
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
                            widget.text != 'woopear'
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
                                ///await FirebaseAuth.instance.signOut();
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
      flexibleSpace: Container(
        height: double.infinity,
      ),

      /// menu affichage team
      bottom: widget.seeMenuProfil && allProfil != null
          ? TabBar(
              labelPadding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
              indicatorColor: Theme.of(context).colorScheme.secondary,
              indicatorWeight: 5,
              tabs: allProfil
                  .map(
                    (profil) => Tab(
                      icon: profil != null && profil.avatar != ''
                          ? CircleAvatar(
                              radius: 40 / 2,
                              backgroundImage: NetworkImage(
                                profil.avatar!,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 40.0,
                            ),
                      text: profil!.firstName.toUpperCase(),
                    ),
                  )
                  .toList())
          : null,
    );
  }
}
