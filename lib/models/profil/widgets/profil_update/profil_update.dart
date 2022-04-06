import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/widgets/profil_update/label.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/widgets/signup/signup_form_companie.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class ProfilUpdate extends ConsumerStatefulWidget {
  ProfilSchema profil;
  void Function()? onPressed;

  ProfilUpdate({
    Key? key,
    required this.profil,
    required this.onPressed,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends ConsumerState<ProfilUpdate> {
  bool _seeFormCompanie = false;

  /// user
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

  /// affiche / cache formulaire companie
  void _forSeeFormCompanie() {
    setState(() {
      _seeFormCompanie = !_seeFormCompanie;
    });
  }

  /// modifie profil et companie
  Future<void> _updateProfil(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              /// label
              buildLabelUpdateProfil(),

              /// formulaire
              ContainerBasic(
                margin: const EdgeInsets.only(top: 40.0),
                child: Form(
                  child: Column(
                    children: [
                      /// first name
                      InputBasic(
                        controller: _firstName,
                        labelText: UserConst.createLabelInputFirstName,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputFirstName,
                          value: value,
                        ),
                      ),

                      /// last name
                      InputBasic(
                        controller: _lastName,
                        labelText: UserConst.createLabelInputLastName,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputLastName,
                          value: value,
                        ),
                      ),

                      /// address
                      InputBasic(
                        controller: _address,
                        labelText: UserConst.createLabelInputAddress,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputAddresse,
                          value: value,
                        ),
                      ),

                      /// codePost
                      InputBasic(
                        controller: _codePost,
                        labelText: UserConst.createLabelInputCodePost,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputCodePost,
                          value: value,
                        ),
                      ),

                      /// city
                      InputBasic(
                        controller: _city,
                        labelText: UserConst.createLabelInputCity,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputCity,
                          value: value,
                        ),
                      ),

                      /// btn affiche / cache formualire companie
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 30.0, bottom: 30.0),
                          child: TextButton(
                            onPressed: _forSeeFormCompanie,
                            child: _seeFormCompanie
                                ? Text(UserConst.createBtnCloseFormCompanie)
                                : const Text('Modifier mon entreprise'),
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

                      /// btn update
                      BtnElevatedBasic(
                        margin: const EdgeInsets.only(top: 20.0),
                        message: 'Modifier profil',
                        onPressed: () async {
                          await _updateProfil(context);
                        },
                        textBtn: 'MODIFIER',
                      ),

                      /// text info formulaire
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          child: Text(
                            '* Champs obigatoire',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// btn update
              Positioned(
                top: 20,
                right: 0,
                child: Tooltip(
                  message: 'Fermer modification',
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        widget.onPressed!();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
