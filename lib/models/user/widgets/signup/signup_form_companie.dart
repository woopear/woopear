import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';

class SignupFormCompanie extends ConsumerStatefulWidget {
  TextEditingController denomination;
  TextEditingController siret;
  TextEditingController codeNaf;
  TextEditingController? addressCompanie;
  TextEditingController? codePostCompanie;
  TextEditingController? cityCompanie;
  TextEditingController? logoCompanie;

  SignupFormCompanie({
    Key? key,
    required this.denomination,
    required this.siret,
    required this.codeNaf,
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
          /// title  
          SubTitlePageAuth(text: UserConst.createCompanieTitleForm),
          
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
          InputBasic(
            controller: widget.siret,
            labelText: UserConst.createCompanieInputSiret,
            validator: (value) => WooValidator.validatorInputTextBasic(
              textError: WooValidator.errorInputSiret,
              value: value,
            ),
          ),

          /// input codeNaf
          InputBasic(
            controller: widget.codeNaf,
            labelText: UserConst.createCompanieInputCodeNaf,
            validator: (value) => WooValidator.validatorInputTextBasic(
              textError: WooValidator.errorInputCodeNaf,
              value: value,
            ),
          ),

          /// input addresse
          InputBasic(
            controller: widget.codeNaf,
            labelText: UserConst.createCompanieInputAddressCompanie,
          ),

          /// input codePost
          InputBasic(
            controller: widget.codeNaf,
            labelText: UserConst.createCompanieInputCodePostCompanie,
          ),

          /// input city
          InputBasic(
            controller: widget.codeNaf,
            labelText: UserConst.createCompanieInputCityCompanie,
          ),

          /// input logo
          /// ? n'est pas important ici
          /// ? sera set avec '' pour avoir la clef coté BDD
        ],
      ),
    );
  }
}
