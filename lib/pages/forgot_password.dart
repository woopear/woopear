import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';
import 'package:woopear/widget_shared/text_information.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text: '');

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void resetInput() {
    _formKey.currentState!.reset();
    _email.clear();
  }

  /// envoie mail pour reset password
  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        /// envoie mail pour reset mot de passe
        await ref.watch(userChange).sendMailResetPassword(_email.text.trim());

        /// on deconnect si user est connecter
        if (ref.watch(profilCurrentProvider) != null) {
          ref.watch(userChange).disconnectUser();
        }

        /// on retourne sur la connexion
        Navigator.popAndPushNamed(context, Routes().appAcces);
      } on FirebaseAuthException catch (e) {
        /// notification error
        NotificationBasic(
          text: e.message,
          error: true,
        ).notification(context);
        throw Exception(e.message);
      }

      resetInput();

      /// notification succes
      NotificationBasic(
        text: UserConst.forgotMessageSucces,
        error: false,
      ).notification(context);
    } else {
      /// notification error
      NotificationBasic(
        text: UserConst.forgotMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarBasic(
          seeConnexion: false,
          text: 'Mot de passe oublié',
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: _width > 700 ? 700.0 : double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContainerBasic(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            /// subtitle
                            TextInfo(text: UserConst.forgotTextInfoForm),

                            /// input email
                            InputBasic(
                              margin: const EdgeInsets.only(top: 30.0),
                              labelText: UserConst.forgotInputEmail,
                              controller: _email,
                              validator: (value) => WooValidator.validateEmail(
                                textError: WooValidator.errorInputEmail,
                                value: value,
                              ),
                            ),

                            /// btn connexion
                            Align(
                              alignment: Alignment.centerRight,
                              child: BtnElevatedBasic(
                                margin: const EdgeInsets.only(top: 30.0),
                                onPressed: () async {
                                  await resetPassword();
                                },
                                textBtn: UserConst.forgotBtn,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
