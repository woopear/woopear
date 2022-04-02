import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_const.dart';
import 'package:woopear/utils/constants/validator/woo_validator.dart';
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
  void seePassword() {
    setState(() {
      _obscureText = !_obscureText!;
    });
  }

  Future<void> createUser(BuildContext context) async {
    if (_formKey.currentState!.validate()){
      /// TODO: creation fonction de creation user + profil
      
      // rest le form
      _formKey.currentState!.reset();
      _email.clear();
      _password.clear();
      _firstName.clear();
      _lastName.clear();
      _address.clear();
      _codePost.clear();
      _city.clear();
      _phoneNumber.clear();
      
      // notification succés
      NotificationBasic(
        text: UserConst.createMessageSucces,
        error: false,
      ).notification(context);
    }else {
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
                    await createUser(context);
                  },
                  textBtn: UserConst.createBtn),
            ),
          ],
        ),
      ),
    );
  }
}
