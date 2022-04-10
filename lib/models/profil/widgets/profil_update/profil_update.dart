import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/companie/companie_schema.dart';
import 'package:woopear/models/profil/profil_const.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/role/role_schema.dart';
import 'package:woopear/models/profil/widgets/profil_update/label.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/models/user/widgets/signup/signup_dropdown_role.dart';
import 'package:woopear/models/user/widgets/signup/signup_form_companie.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class ProfilUpdate extends ConsumerStatefulWidget {
  ProfilSchema profil;
  bool updateRole;
  void Function()? onPressed;

  ProfilUpdate({
    Key? key,
    required this.profil,
    required this.updateRole,
    required this.onPressed,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends ConsumerState<ProfilUpdate> {
  bool _seeFormCompanie = false;
  final _formKey = GlobalKey<FormState>();

  /// user
  TextEditingController _firstName = TextEditingController(text: '');
  TextEditingController _lastName = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _codePost = TextEditingController(text: '');
  TextEditingController _city = TextEditingController(text: '');
  TextEditingController _phoneNumber = TextEditingController(text: '');

  /// info pour role root
  TextEditingController _post = TextEditingController(text: '');
  TextEditingController _description = TextEditingController(text: '');
  TextEditingController _techno = TextEditingController(text: '');
  TextEditingController _infoComplementaire = TextEditingController(text: '');

  /// companie
  TextEditingController _denomination = TextEditingController(text: '');
  TextEditingController _siret = TextEditingController(text: '');
  TextEditingController _codeNaf = TextEditingController(text: '');
  TextEditingController _addressCompanie = TextEditingController(text: '');
  TextEditingController _codePostCompanie = TextEditingController(text: '');
  TextEditingController _cityCompanie = TextEditingController(text: '');
  TextEditingController _logoCompanie = TextEditingController(text: '');

  RoleSchema? _role;

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController(text: widget.profil.firstName);
    _lastName = TextEditingController(text: widget.profil.lastName);
    _address = TextEditingController(text: widget.profil.address);
    _codePost = TextEditingController(text: widget.profil.codePost);
    _city = TextEditingController(text: widget.profil.city);
    _phoneNumber = TextEditingController(text: widget.profil.phoneNumber);

    _denomination =
        TextEditingController(text: widget.profil.companie!.denomination);
    _siret = TextEditingController(text: widget.profil.companie!.siret);
    _codeNaf = TextEditingController(text: widget.profil.companie!.codeNaf);
    _addressCompanie =
        TextEditingController(text: widget.profil.companie!.address);
    _codePostCompanie =
        TextEditingController(text: widget.profil.companie!.codePost);
    _cityCompanie = TextEditingController(text: widget.profil.companie!.city);
    _logoCompanie = TextEditingController(text: widget.profil.companie!.logo);
    _role = widget.profil.role;

    /// info pour role root
    _post = TextEditingController(text: widget.profil.post);
    _description = TextEditingController(text: widget.profil.description);
    _techno = TextEditingController(text: widget.profil.techno);
    _infoComplementaire =
        TextEditingController(text: widget.profil.infoComplementary);
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _address.dispose();
    _codePost.dispose();
    _city.dispose();
    _phoneNumber.dispose();
    _denomination.dispose();
    _siret.dispose();
    _codeNaf.dispose();
    _addressCompanie.dispose();
    _codePostCompanie.dispose();
    _cityCompanie.dispose();
    _logoCompanie.dispose();
    super.dispose();
  }

  /// affiche / cache formulaire companie
  void _forSeeFormCompanie() {
    setState(() {
      _seeFormCompanie = !_seeFormCompanie;
    });
  }

  /// selection du role
  void setRole(RoleSchema? role) {
    setState(() {
      _role = role;
    });
  }

  /// modifie profil et companie
  Future<void> _updateProfil(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_role == null) {
        /// notification error
        NotificationBasic(
          text: ProfilConst.errorRole,
          error: true,
        ).notification(context);
        throw Exception(ProfilConst.errorRole);
      }

      /// creation profil
      ProfilSchema newProfil = ProfilSchema(
        email: widget.profil.email,
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        userName: _firstName.text.trim() + ' ' + _lastName.text.trim(),
        address: _address.text.trim(),
        city: _city.text.trim(),
        codePost: _codePost.text.trim(),
        phoneNumber: _phoneNumber.text.trim(),
        uid: widget.profil.uid,
        avatar: widget.profil.avatar,
        role: RoleSchema(
            libelle: _role!.libelle, description: _role!.description),
      );

      if (_role!.libelle == 'root') {
        /// ajout des info pour role root
        newProfil.post = _post.text.trim();
        newProfil.description = _description.text.trim();
        newProfil.techno = _techno.text.trim();
        newProfil.infoComplementary = _infoComplementaire.text.trim();
      }

      /// si companie creer companie
      /// si addresse de la companie n'est pas renseigner
      /// mettre addresse user

      /// on creer la companie

      if (_denomination.text != '' &&
          _siret.text != '' &&
          _codeNaf.text != '') {
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
          logo: '',
        );

        /// on affecte la companie au user
        newProfil.companie = newCompanie;
      } else {
        CompanieSchema newCompanie = CompanieSchema(
          codeNaf: '',
          siret: '',
          denomination: '',
          address: '',
          codePost: '',
          city: '',
          logo: '',
        );

        /// on affecte la companie au user
        newProfil.companie = newCompanie;
      }

      try {
        await ref
            .watch(profilChange)
            .updateProfil(newProfil, widget.profil.id!);

        /// notification succes
        NotificationBasic(
          text: "Profil modifié",
          error: false,
        ).notification(context);
      } catch (e) {
        /// notification error
        NotificationBasic(
          text: "Les modifications n'ont pas pu etre appliquée",
          error: true,
        ).notification(context);
      }
    } else {
      /// notification error
      NotificationBasic(
        text: "Impossible d'appliquer les modifications",
        error: true,
      ).notification(context);
    }
  }

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
                  key: _formKey,
                  child: Column(
                    children: [
                      widget.updateRole
                          ?

                          /// input role
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: SignupDropdownRole(
                                  dropdownValue: _role,
                                  onChanged: (value) => setRole(value),
                                ),
                              ),
                            )
                          : Container(),

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

                      /// phone number
                      InputBasic(
                        controller: _phoneNumber,
                        labelText: UserConst.createLabelInputPhoneNumber,
                      ),

                      /// input post
                      InputBasic(
                        labelText: 'Métier, poste, emploi *',
                        controller: _post,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputPostRoleRoot,
                          value: value,
                        ),
                      ),

                      /// input description
                      InputBasic(
                        margin: const EdgeInsets.only(top: 10.0),
                        labelText: 'Description de vous *',
                        controller: _description,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputDescitionRoleRoot,
                          value: value,
                        ),
                      ),

                      /// input techno
                      InputBasic(
                        margin: const EdgeInsets.only(top: 10.0),
                        labelText: 'Les technos pratiquées *',
                        controller: _techno,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputTechnoRoleRoot,
                          value: value,
                        ),
                      ),

                      /// input infoComplementaire
                      InputBasic(
                        margin: const EdgeInsets.only(top: 10.0),
                        labelText: 'Des infos supplémentaire*',
                        controller: _infoComplementaire,
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputInfoRoleRoot,
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
