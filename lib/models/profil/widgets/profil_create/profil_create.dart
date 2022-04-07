import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_const.dart';
import 'package:woopear/models/profil/widgets/profil_create/profil_create_form.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/title_page_auth.dart';

class ProfilCreate extends ConsumerStatefulWidget {
  const ProfilCreate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilCreateState();
}

class _ProfilCreateState extends ConsumerState<ProfilCreate> {
  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: _width > 700 ? 700.0 : double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            /// Card
            ContainerBasic(
              child: Column(
                children: [
                  // title de la card
                  Container(
                    margin: _width > 700
                        ? const EdgeInsets.only(bottom: 50.0)
                        : const EdgeInsets.only(bottom: 20.0),
                    child: TitlePageAuth(text: ProfilConst.titlePage)
                  ),

                  /// formulaire de connexion user
                  const ProfilCreateForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
