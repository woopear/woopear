import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class SignupFormCompanie extends ConsumerStatefulWidget {
  TextEditingController denomination;
  TextEditingController siret;
  TextEditingController? codeNaf;
  TextEditingController? addressCompanie;
  TextEditingController? codePostCompanie;
  TextEditingController? cityCompanie;
  TextEditingController? logoCompanie;

  SignupFormCompanie({
    Key? key,
    required this.denomination,
    required this.siret,
    this.codeNaf,
    this.addressCompanie,
    this.cityCompanie,
    this.codePostCompanie,
    this.logoCompanie,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignupFormCompanieState();
}

class _SignupFormCompanieState extends ConsumerState<SignupFormCompanie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: [
          /// input denomination
          InputBasic(
            controller: widget.denomination,
            labelText: UserConst.createCompanieInputDenomination,
            validator: (value) => WooValidator.validatorInputTextBasic(
              textError: WooValidator.errorInputFirstName,
              value: value,
            ),
          ),

          /// input siret

          /// input codeNaf

          /// input addresse

          /// input codePost

          /// input city

          /// input logo
        ],
      ),
    );
  }
}
