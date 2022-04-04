import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/widgets/signin/signin.dart';

class Connexion extends ConsumerStatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConnexionState();
}

class _ConnexionState extends ConsumerState<Connexion> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                /// connexion
                Signin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}