import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/widgets/signin/signin_form.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/title_page_auth.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: _width > 700 ? 500.0 : double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            /// Card
            ContainerBasic(
              child: Column(
                children: [
                  /// title de la card
                  Container(
                    margin: _width > 700
                        ? const EdgeInsets.only(bottom: 50.0)
                        : const EdgeInsets.only(bottom: 20.0),
                    child: TitlePageAuth(
                      text: UserConst.connexionTitle,
                    ),
                  ),

                  /// formulaire de connexion user
                  const SigninForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}