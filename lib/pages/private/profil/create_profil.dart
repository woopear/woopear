import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/widgets/profil_create/profil_create.dart';

class CreateProfil extends ConsumerStatefulWidget {
  const CreateProfil({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProfilState();
}

class _CreateProfilState extends ConsumerState<CreateProfil> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
    );
  }
}