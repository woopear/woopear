import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/companie/companie_schema.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/models/user/widgets/signup/signup_form_companie.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
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
  final _formKey2 = GlobalKey<FormState>();

  /// user
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _firstName = TextEditingController(text: '');
  final TextEditingController _lastName = TextEditingController(text: '');
  final TextEditingController _address = TextEditingController(text: '');
  final TextEditingController _codePost = TextEditingController(text: '');
  final TextEditingController _city = TextEditingController(text: '');
  final TextEditingController _phoneNumber = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  /// info pour role root
  final TextEditingController _post = TextEditingController(text: '');
  final TextEditingController _description = TextEditingController(text: '');
  final TextEditingController _techno = TextEditingController(text: '');
  final TextEditingController _infoComplementaire =
      TextEditingController(text: '');

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
    _post.dispose();
    _description.dispose();
    _techno.dispose();
    _infoComplementaire.dispose();
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

    /// companie
    _denomination.clear();
    _addressCompanie.clear();
    _cityCompanie.clear();
    _codeNaf.clear();
    _siret.clear();
    _codePostCompanie.clear();
    _logoCompanie.clear();
  }

  /// reset input pour role root
  void _resetInputRoleRoot() {
    _post.clear();
    _description.clear();
    _techno.clear();
    _infoComplementaire.clear();
    _formKey2.currentState!.reset();
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
      /// recupere profil par rapport à l'email fournis
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
        role: profil.role,
      );

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

        if (profil.role.libelle == 'root') {
          final profilCreated = await ref
              .watch(profilChange)
              .getProfilForCreateAuthForTestEmail(_email.text);

          /// modal pour info user role root
          showModalBottomSheet(
              isDismissible: false,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              context: context,
              builder: (context) {
                return buildModalROleRoot(context, profilCreated!);
              });
        } else {
          /// reset input form
          _resetAllInput();

          // notification succés
          NotificationBasic(
            text: UserConst.createMessageSucces,
            error: false,
          ).notification(context);

          /// on va sur la page d'acces du compte
          Navigator.popAndPushNamed(context, Routes().appAcces);
        }
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
    } else {
      // notification error
      NotificationBasic(
        text: UserConst.createMessageError,
        error: true,
      ).notification(context);
    }
  }

  Future<void> _updateInfoUserRoleRoot(ProfilSchema profil) async {
    if (_formKey2.currentState!.validate()) {
      /// creation new profil
      final newProfil = profil;

      /// ajout des info pour role root
      newProfil.post = _post.text.trim();
      newProfil.description = _description.text.trim();
      newProfil.techno = _techno.text.trim();
      newProfil.infoComplementary = _infoComplementaire.text.trim();

      /// modification bdd des info user root
      await ref.watch(profilChange).updateProfil(newProfil, newProfil.id!);

      /// reset input form
      _resetAllInput();

      /// reset input role root
      _resetInputRoleRoot();

      // notification succés
      NotificationBasic(
        text: UserConst.createMessageSucces,
        error: false,
      ).notification(context);

      /// on va sur la page d'acces du compte
      Navigator.popAndPushNamed(context, Routes().appAcces);
    } else {
      // notification error
      NotificationBasic(
        text: 'Impossible de mettre à jour les iinformations',
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

  /// widget modal pour creation user root
  Widget buildModalROleRoot(BuildContext context, ProfilSchema profil) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// title
          Container(
            margin: const EdgeInsets.only(top: 70.0),
            child: const Text('Informations utilisateur root'),
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 50.0),
            child: Text(
              'Vous êtes un utilisateur root, vous devez donc remplir ses informations, qui apparaitrons sur votre profil de woopear',
              style: const TextStyle().copyWith(
                fontSize: 14.0,
              ),
            ),
          ),

          /// Form
          ContainerBasic(
            width: _width > 700 ? 600 : double.infinity,
            child: Form(
              key: _formKey2,
              child: Column(
                children: [
                  /// input post
                  InputBasic(
                    labelText: 'Métier, poste, emploi *',
                    controller: _post,
                    validator: (value) => WooValidator.validatorInputTextBasic(
                      textError: WooValidator.errorInputPostRoleRoot,
                      value: value,
                    ),
                  ),

                  /// input description
                  InputBasic(
                    margin: const EdgeInsets.only(top: 10.0),
                    labelText: 'Description de vous *',
                    controller: _description,
                    validator: (value) => WooValidator.validatorInputTextBasic(
                      textError: WooValidator.errorInputDescitionRoleRoot,
                      value: value,
                    ),
                  ),

                  /// input techno
                  InputBasic(
                    margin: const EdgeInsets.only(top: 10.0),
                    labelText: 'Les technos pratiquées *',
                    controller: _techno,
                    validator: (value) => WooValidator.validatorInputTextBasic(
                      textError: WooValidator.errorInputTechnoRoleRoot,
                      value: value,
                    ),
                  ),

                  /// input infoComplementaire
                  InputBasic(
                    margin: const EdgeInsets.only(top: 10.0),
                    labelText: 'Des infos supplémentaire*',
                    controller: _infoComplementaire,
                    validator: (value) => WooValidator.validatorInputTextBasic(
                      textError: WooValidator.errorInputInfoRoleRoot,
                      value: value,
                    ),
                  ),

                  /// btn update profil root
                  BtnElevatedBasic(
                    margin: const EdgeInsets.only(top: 40.0),
                    onPressed: () async {
                      await _updateInfoUserRoleRoot(profil);
                    },
                    textBtn: 'ENREGISTRER',
                  ),

                  /// text info formulaire
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// info basic
                          Text(
                            UserConst.createInfoForm,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),

                          /// info pour techno
                          Container(
                            child: Text(
                              'Pour le champs techno, veuillez utiliser ce format : techno1;techno2;techno3;techno4 etc...',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
