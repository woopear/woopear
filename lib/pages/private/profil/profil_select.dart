import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/widgets/profil_image/profil_image.dart';
import 'package:woopear/models/profil/widgets/profil_info.dart/profil_info.dart';
import 'package:woopear/models/profil/widgets/profil_info_companie/profil_info_companie.dart';
import 'package:woopear/models/profil/widgets/profil_update/profil_update.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';

class ProfilSelect extends ConsumerStatefulWidget {
  ProfilSchema profil;
  ProfilSelect({Key? key, required this.profil}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilSelectState();
}

class _ProfilSelectState extends ConsumerState<ProfilSelect> {
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBarBasic(
          seeConnexion: false,
          text: widget.profil.userName != ''
              ? widget.profil.userName!
              : 'Sans nom',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: _width > 700 ? 700.0 : double.infinity,
              margin: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  /// image + nom prenom
                  ProfilImage(
                    urlAvatar: widget.profil.avatar!,
                    profil: widget.profil,
                  ),

                  /// si true on affiche update
                  _seeUpdate
                      ? ProfilUpdate(
                          profil: widget.profil,
                          onPressed: _openCloseUpdateInfo,
                        )
                      : Column(
                          children: [
                            /// info profil
                            ProfilInfo(
                              profil: widget.profil,
                              onPressed: _openCloseUpdateInfo,
                              seeUpdate: _seeUpdate,
                            ),

                            /// partie entreprise
                            ProfilInfoCompanie(
                              companie: widget.profil.companie!,
                              seeUpdate: _seeUpdate,
                            ),
                          ],
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
                            child: const Text('Modifier le mot de passe'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
