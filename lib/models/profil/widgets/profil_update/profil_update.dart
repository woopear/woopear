import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/widgets/profil_update/label.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class ProfilUpdate extends ConsumerStatefulWidget {
  ProfilSchema profil;

  ProfilUpdate({Key? key, required this.profil}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilUpdateState();
}

class _ProfilUpdateState extends ConsumerState<ProfilUpdate> {
  /// user
  final TextEditingController _firstName = TextEditingController(text: '');
  final TextEditingController _lastName = TextEditingController(text: '');
  final TextEditingController _address = TextEditingController(text: '');
  final TextEditingController _codePost = TextEditingController(text: '');
  final TextEditingController _city = TextEditingController(text: '');
  final TextEditingController _phoneNumber = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70.0, left: 30.0, right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// label
          buildLabelUpdateProfil(),

          /// formulaire
          ContainerBasic(
            margin: const EdgeInsets.only(top: 15.0),
            child: Form(
              child: Column(
                children: [
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
        ],
      ),
    );
  }
}
