import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';

class Presentation extends ConsumerStatefulWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PresentationState();
}

class _PresentationState extends ConsumerState<Presentation> {
  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: 'Gestion présentation',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(),
        ),
      ),
    );
  }
}
