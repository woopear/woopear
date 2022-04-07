import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/widgets/profil_image/profil_image.dart';
import 'package:woopear/models/profil/widgets/profil_info.dart/profil_info.dart';
import 'package:woopear/models/profil/widgets/profil_info_companie/profil_info_companie.dart';
import 'package:woopear/models/profil/widgets/profil_update/profil_update.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';

class Account extends ConsumerStatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  bool _seeUpdate = false;

  /// affiche / cache update info
  void _openCloseUpdateInfo() {
    setState(() {
      _seeUpdate = !_seeUpdate;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    /// on recupere le user
    final profil = ref.watch(profilCurrentProvider);

    /// on recupere les infos du currentUser
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: 'Mon compte',
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: _width > 700 ? 700.0 : double.infinity,
                margin: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  children: [
                    /// image + nom prenom
                    profil != null
                        ? ProfilImage(
                            urlAvatar: profil.avatar!,
                            profil: profil,
                          )
                        : Container(
                            child: const Text('Aucun utilisateur connecté'),
                          ),

                    /// si true on affiche update
                    profil != null
                        ? _seeUpdate
                            ? ProfilUpdate(
                                updateRole: false,
                                profil: profil,
                                onPressed: _openCloseUpdateInfo,
                              )
                            : Column(
                                children: [
                                  /// info profil
                                  ProfilInfo(
                                    profil: profil,
                                    onPressed: _openCloseUpdateInfo,
                                    seeUpdate: _seeUpdate,
                                  ),

                                  /// partie entreprise
                                  ProfilInfoCompanie(
                                    companie: profil.companie!,
                                    seeUpdate: _seeUpdate,
                                  ),
                                ],
                              )
                        : Container(
                            child: const Text('Aucun utilisateur connecté'),
                          ),

                    /// btn modifier mot de passe
                    Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes().forgotPassword);
                              },
                              child: const Text('Modifier mon mot de passe'))
                        ],
                      ),
                    ),

                    /// btn supprimer mon compte
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              await ref
                                  .watch(userChange)
                                  .deleteUser(user!.uid, profil!.id!);
                            },
                            child: Text(
                              'Supprimer mon compte',
                              style: const TextStyle().copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
