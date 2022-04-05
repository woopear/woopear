import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/widgets/profil_image/profil_image.dart';
import 'package:woopear/models/profil/widgets/profil_info.dart/profil_info.dart';
import 'package:woopear/models/profil/widgets/profil_info_companie/profil_info_companie.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';

class ProfilSelect extends ConsumerStatefulWidget {
  ProfilSchema profil;
  ProfilSelect({Key? key, required this.profil}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilSelectState();
}

class _ProfilSelectState extends ConsumerState<ProfilSelect> {
  @override
  Widget build(BuildContext context) {
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
              margin: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  /// image + nom prenom
                  ProfilImage(
                    urlAvatar: widget.profil.avatar!,
                    profil: widget.profil,
                  ),

                  /// info profil
                  ProfilInfo(profil: widget.profil),

                  /// partie entreprise
                  /// si entreprise on affiche sinon 
                  /// btn ajouter entreprise, qui enverra sur la modification 
                  /// profil où il y aura la creation/update companie
                  ProfilInfoCompanie(profil: widget.profil),

                  /// btn supprimer + modifier mot de passe
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
