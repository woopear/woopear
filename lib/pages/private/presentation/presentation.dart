import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:woopear/models/presentation/presentation_const.dart';
import 'package:woopear/models/presentation/widgets/presentation_create/presentation_create.dart';
import 'package:woopear/models/presentation/widgets/presentation_list/presentation_list.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';

class Presentation extends ConsumerStatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PresentationState();
}

class _PresentationState extends ConsumerState<Presentation> {
  bool _seePresentationList = true;
  bool _seePresentationCreate = false;

  /// affiche / cache list presentation
  void _openCloseSeePresentationList() {
    setState(() {
      _seePresentationList = true;
      _seePresentationCreate = false;
    });
  }

  /// affiche / cache creation presentation
  void _openCloseSeePresentationCreate() {
    setState(() {
      _seePresentationList = false;
      _seePresentationCreate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: PresentationConst.pageTitle,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                /// list presentation
                _seePresentationList ? const PresentationList() : Container(),

                /// creation presentation
                _seePresentationCreate ? const PresentationCreate() : Container(),
                
              ],
            ),
          ),
        ),

        /// menu de la page
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spacing: 20.0,
          spaceBetweenChildren: 20.0,
          foregroundColor: Colors.white,
          children: [
            /// icon menu ajouter un profil
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: 'Créer une présentation',
                onTap: () {
                  _openCloseSeePresentationCreate();
                }),

            /// icon menu liste des profils
            SpeedDialChild(
                child: const Icon(Icons.list),
                label: 'Liste des présentations',
                onTap: () {
                  _openCloseSeePresentationList();
                }),
          ],
        ),
      ),
    );
  }
}
