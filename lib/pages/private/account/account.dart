import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';

class Account extends ConsumerStatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountState();
}

class _AccountState extends ConsumerState<Account> {
  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = ref.watch(profilCurrentProvider);

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
            child: Container(),
          ),
        ),
      ),
    );
  }
}
