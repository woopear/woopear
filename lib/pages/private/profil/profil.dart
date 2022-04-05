import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/widgets/profil_create/profil_create.dart';
import 'package:woopear/models/profil/widgets/profil_list/profil_list.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';

class ProfilPage extends ConsumerStatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProfilState();
}

class _CreateProfilState extends ConsumerState<ProfilPage> {
  bool _seeListProfil = true;
  bool _seeCreateProfil = false;

  void seeList() {
    setState(() {
      _seeListProfil = true;
      _seeCreateProfil = false;
    });
  }

  void seeCreate() {
    setState(() {
      _seeListProfil = false;
      _seeCreateProfil = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = ref.watch(profilCurrentProvider);

    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: 'Gestion clients',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                /// list profil
                _seeListProfil ? const ProfilList() : Container(),

                /// creation profil
                _seeCreateProfil ? const ProfilCreate() : Container()
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
                label: 'Créer un profil',
                onTap: () {
                  seeCreate();
                }),

            /// icon menu liste des profils
            SpeedDialChild(
                child: const Icon(Icons.list),
                label: 'Liste des profil',
                onTap: () {
                  seeList();
                }),
          ],
        ),
      ),
    );
  }
}
