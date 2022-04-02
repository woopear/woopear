import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  bool? _obscureText;

  /// init de la class
  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  /// afficher / cacher password
  void seePassword() {
    setState(() {
      _obscureText = !_obscureText!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            /// email
            InputBasic(
              labelText: 'Email',
            ),

            /// password
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                obscureText: _obscureText!,
                decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    suffixIcon: InkWell(
                      onTap: seePassword,
                      child: Icon(_obscureText!
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
              ),
            ),

            /// first name
            InputBasic(
              labelText: 'Prénom',
            ),

            /// last name
            InputBasic(labelText: 'Nom'),

            /// address
            InputBasic(labelText: 'Addresse'),

            /// codePost
            InputBasic(labelText: 'Code postal'),

            /// city
            InputBasic(labelText: 'Ville'),

            /// phone number
            InputBasic(labelText: 'Numéro de téléphone'),

            /// btn creation
            Align(
              child: BtnElevatedBasic(onPressed: () {}, textBtn: 'CREER'),
            ),
          ],
        ),
      ),
    );
  }
}
