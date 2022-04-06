import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/companie/companie_schema.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/role/role_schema.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/models/user/widgets/signup/signup_form_companie.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/input_password.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  bool? _obscureText;
  bool _seeFormCompanie = false;
  final _formKey = GlobalKey<FormState>();

  /// user
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _firstName = TextEditingController(text: '');
  final TextEditingController _lastName = TextEditingController(text: '');
  final TextEditingController _address = TextEditingController(text: '');
  final TextEditingController _codePost = TextEditingController(text: '');
  final TextEditingController _city = TextEditingController(text: '');
  final TextEditingController _phoneNumber = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  /// companie
  final TextEditingController _denomination = TextEditingController(text: '');
  final TextEditingController _siret = TextEditingController(text: '');
  final TextEditingController _codeNaf = TextEditingController(text: '');
  final TextEditingController _addressCompanie =
      TextEditingController(text: '');
  final TextEditingController _codePostCompanie =
      TextEditingController(text: '');
  final TextEditingController _cityCompanie = TextEditingController(text: '');
  final TextEditingController _logoCompanie = TextEditingController(text: '');
  RoleSchema? _role;

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
    _firstName.dispose();
    _lastName.dispose();
    _address.dispose();
    _codePost.dispose();
    _city.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  /// afficher / cacher password
  void _seePassword() {
    setState(() {
      _obscureText = !_obscureText!;
    });
  }

  /// reset input
  void _resetAllInput() {
    // rest le form
    /// user
    _formKey.currentState!.reset();
    _email.clear();
    _password.clear();
    _firstName.clear();
    _lastName.clear();
    _address.clear();
    _codePost.clear();
    _city.clear();
    _phoneNumber.clear();
    setState(() {
      _role = null;
    });

    /// companie
    _denomination.clear();
    _addressCompanie.clear();
    _cityCompanie.clear();
    _codeNaf.clear();
    _siret.clear();
    _codePostCompanie.clear();
    _logoCompanie.clear();
  }

  /// afficher / cacher formulaire companie
  void _forSeeFormCompanie() {
    setState(() {
      _seeFormCompanie = !_seeFormCompanie;
    });
  }

  /// creation d'un utilisateur
  Future<void> _createUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// recupere profi par rapport à l'email fournis
      final profil = await ref
          .watch(profilChange)
          .getProfilForCreateAuthForTestEmail(_email.text);

      if (profil == null || profil.uid != '') {
        // notification error
        NotificationBasic(
          text: UserConst.createMessageError,
          error: true,
        ).notification(context);
        throw Exception(UserConst.createMessageError);
      }

      /// creation profil
      ProfilSchema newProfil = ProfilSchema(
          email: profil.email,
          firstName: _firstName.text.trim(),
          lastName: _lastName.text.trim(),
          userName: _firstName.text.trim() + ' ' + _lastName.text.trim(),
          address: _address.text.trim(),
          city: _city.text.trim(),
          codePost: _codePost.text.trim(),
          uid: '',
          role: profil.role);

      /// si companie creer companie
      /// si addresse de la companie n'est pas renseigner
      /// mettre addresse user
      if (_denomination.text != '' &&
          _siret.text != '' &&
          _codeNaf.text != '') {
        /// on creer la companie
        CompanieSchema newCompanie = CompanieSchema(
            codeNaf: _codeNaf.text.trim(),
            siret: _siret.text.trim(),
            denomination: _denomination.text.trim(),
            address: _addressCompanie.text != ''
                ? _addressCompanie.text.trim()
                : newProfil.address,
            codePost: _codePostCompanie.text != ''
                ? _codePostCompanie.text.trim()
                : newProfil.codePost,
            city: _cityCompanie.text != ''
                ? _cityCompanie.text.trim()
                : newProfil.city,
            logo: '');

        /// on affecte la companie au user
        newProfil.companie = newCompanie;
      }

      /// creation fonction de creation user + profil
      try {
        /// creation user + profil
        await ref
            .watch(userChange)
            .createAuth(_email, _password, newProfil, profil.id!);

        /// on va sur la page d'acces du compte
        Navigator.popAndPushNamed(context, Routes().appAcces);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          NotificationBasic(
            text: UserConst.createMessageEmailError,
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception(UserConst.createMessageEmailError);
        }

        /// email errorné
        if (e.code == 'user-not-found') {
          NotificationBasic(
            text: UserConst.createMessageEmailError,
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception(UserConst.createMessageEmailError);
        } else if (e.code == 'wrong-password') {
          /// mot de passe érroné
          NotificationBasic(
            text: UserConst.createMessagePasswordError,
            error: true,
          ).notification(context);
          Navigator.of(context, rootNavigator: true).pop();
          throw Exception(UserConst.createMessagePasswordError);
        }
      }

      /// reset input form
      _resetAllInput();

      // notification succés
      NotificationBasic(
        text: UserConst.createMessageSucces,
        error: false,
      ).notification(context);
    } else {
      // notification error
      NotificationBasic(
        text: UserConst.createMessageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// email
            InputBasic(
              controller: _email,
              labelText: UserConst.createLabelInputEmail,
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
              onTap: _seePassword,
              validator: (value) => WooValidator.validatePassword(
                textError: WooValidator.errorInputPassword,
                value: value,
              ),
            ),

            /// first name
            InputBasic(
              controller: _firstName,
              labelText: UserConst.createLabelInputFirstName,
              validator: (value) => WooValidator.validatorInputTextBasic(
                textError: WooValidator.errorInputFirstName,
                value: value,
              ),
            ),

            /// last name
            InputBasic(
              controller: _lastName,
              labelText: UserConst.createLabelInputLastName,
              validator: (value) => WooValidator.validatorInputTextBasic(
                textError: WooValidator.errorInputLastName,
                value: value,
              ),
            ),

            /// address
            InputBasic(
              controller: _address,
              labelText: UserConst.createLabelInputAddress,
              validator: (value) => WooValidator.validatorInputTextBasic(
                textError: WooValidator.errorInputAddresse,
                value: value,
              ),
            ),

            /// codePost
            InputBasic(
              controller: _codePost,
              labelText: UserConst.createLabelInputCodePost,
              validator: (value) => WooValidator.validatorInputTextBasic(
                textError: WooValidator.errorInputCodePost,
                value: value,
              ),
            ),

            /// city
            InputBasic(
              controller: _city,
              labelText: UserConst.createLabelInputCity,
              validator: (value) => WooValidator.validatorInputTextBasic(
                textError: WooValidator.errorInputCity,
                value: value,
              ),
            ),

            /// phone number
            InputBasic(
              controller: _phoneNumber,
              labelText: UserConst.createLabelInputPhoneNumber,
            ),

            /// btn affiche / cache formualire companie
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                child: TextButton(
                  onPressed: _forSeeFormCompanie,
                  child: _seeFormCompanie
                      ? Text(UserConst.createBtnCloseFormCompanie)
                      : Text(UserConst.createBtnSeeFormCompanie),
                ),
              ),
            ),

            /// formulaire companie
            _seeFormCompanie
                ? SignupFormCompanie(
                    denomination: _denomination,
                    siret: _siret,
                    addressCompanie: _addressCompanie,
                    cityCompanie: _cityCompanie,
                    codeNaf: _codeNaf,
                    codePostCompanie: _codePostCompanie,
                    logoCompanie: _logoCompanie,
                  )
                : Container(),

            BtnElevatedBasic(
              margin: const EdgeInsets.only(top: 30.0),
              message: UserConst.createTooltipBtnResetInput,
              onPressed: _resetAllInput,
              textBtn: UserConst.createBtnResetInput,
            ),

            BtnElevatedBasic(
              margin: const EdgeInsets.only(top: 20.0),
              message: UserConst.createTooltipBtn,
              onPressed: () async {
                await _createUser(context);
              },
              textBtn: UserConst.createBtn,
            ),

            /// text info formulaire
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Text(
                  UserConst.createInfoForm,
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
