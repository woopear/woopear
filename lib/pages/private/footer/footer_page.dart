import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/footer/footer_state.dart';
import 'package:woopear/models/footer/widgets/footer_create/footer_create.dart';
import 'package:woopear/models/footer/widgets/footer_update/footer_update.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class FooterPage extends ConsumerStatefulWidget {
  const FooterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterPageState();
}

class _FooterPageState extends ConsumerState<FooterPage> {
  @override
  void initState() {
    super.initState();

    /// si deconnecter retour sur la page app (connexion ou dashboard)
    if (FirebaseAuth.instance.currentUser == null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes().appAcces);
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: 'Gestion footer',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: _width > 700 ? 600 : double.infinity,
            padding: const EdgeInsets.all(30.0),
            child: ref.watch(footersStream).when(
                  data: (footers) {
                    /// si vide on affiche create sinon on affiche update
                    return footers.isEmpty ? const FooterCreate() : const FooterUpdate();
                  },
                  error: (error, stack) => const WaitingError(),
                  loading: () => const WaitingData(),
                ),
          ),
        ),
      ),
    );
  }
}
