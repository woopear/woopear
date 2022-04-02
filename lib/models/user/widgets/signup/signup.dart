import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/widgets/signup/signup_form.dart';
import 'package:woopear/widget_shared/card_basic.dart';
import 'package:woopear/widget_shared/title_page_auth.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
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
            CardBasic(
              child: Column(
                children: [
                  /// title de la card
                  Container(
                    margin: _width > 700
                        ? const EdgeInsets.only(bottom: 50.0)
                        : const EdgeInsets.only(bottom: 20.0),
                    child: TitlePageAuth(
                      text: UserConst.createTitle,
                    ),
                  ),

                  /// formulaire
                  const SignupForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
