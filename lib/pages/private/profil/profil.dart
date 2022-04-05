import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/widgets/profil_create/profil_create.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';

class ProfilPage extends ConsumerStatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProfilState();
}

class _CreateProfilState extends ConsumerState<ProfilPage> {
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
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: const [
                  /// creation profil
                  ProfilCreate(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
