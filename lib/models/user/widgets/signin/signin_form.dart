import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/input_password.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class SigninForm extends ConsumerStatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SigninFormState();
}

class _SigninFormState extends ConsumerState<SigninForm> {
  bool? _obscureText;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  /// init de la class
  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  /// reset des controllers des inputs
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// afficher / cacher password
  void seePassword() {
    setState(() {
      _obscureText = !_obscureText!;
    });
  }

  /// mot de passe oublié
  void forgotPassword() {
    /// TODO: faire mot de passe oublié
  }

  /// reset all input
  void resetInput() {
    // rest le form
    _formKey.currentState!.reset();
    _email.clear();
    _password.clear();
  }

  /// connexion utilisateur + ecoute profil
  Future<void> connexionUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// connexion user
      await ref.watch(userChange).connexionUser(_email, _password);

      // rest le form
      resetInput();

      // notification succés
      NotificationBasic(
        text: UserConst.connexionMessageSucces,
        error: false,
      ).notification(context);
    } else {
      // notification error
      NotificationBasic(
        text: UserConst.connexionMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// input email
            InputBasic(
              labelText: UserConst.connexionLabelInputEmail,
              controller: _email,
              validator: (value) => WooValidator.validateEmail(
                textError: WooValidator.errorInputEmail,
                value: value,
              ),
            ),

            /// input password
            InputPassword(
              obscureText: _obscureText!,
              labelText: UserConst.connexionLabelInputPassword,
              controller: _password,
              onTap: seePassword,
              validator: (value) => WooValidator.validatePassword(
                textError: WooValidator.errorInputPassword,
                value: value,
              ),
            ),

            /// mot de passe oublié
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 40.0, top: 20.0),
                child: TextButton(
                  onPressed: forgotPassword,
                  child: Text(
                    UserConst.connexionBtnPasswordForgot,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
            ),

            /// btn connexion
            Align(
              alignment: Alignment.centerRight,
              child: BtnElevatedBasic(
                onPressed: () async {
                  await connexionUser(context);
                },
                textBtn: UserConst.connexionBtn,
              ),
            ),

            /// text info formulaire
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Text(
                  UserConst.connexionInfoForm,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
