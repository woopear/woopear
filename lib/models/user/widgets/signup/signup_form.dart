import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/utils/constants/validator/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/input_password.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  bool? _obscureText;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');
  final TextEditingController _firstName = TextEditingController(text: '');
  final TextEditingController _lastName = TextEditingController(text: '');
  final TextEditingController _address = TextEditingController(text: '');
  final TextEditingController _codePost = TextEditingController(text: '');
  final TextEditingController _city = TextEditingController(text: '');
  final TextEditingController _phoneNumber = TextEditingController(text: '');

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

  Future<void> createUser() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
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

            /// password
            InputPassword(
              controller: _password,
              obscureText: _obscureText!,
              labelText: UserConst.createLabelInputPassword,
              onTap: seePassword,
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

            /// btn creation
            Align(
              alignment: Alignment.centerRight,
              child: BtnElevatedBasic(
                  message: UserConst.createTooltipBtn,
                  onPressed: () async {
                    await createUser();
                  },
                  textBtn: UserConst.createBtn),
            ),
          ],
        ),
      ),
    );
  }
}
