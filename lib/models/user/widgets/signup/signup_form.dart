import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children:  [
            /// first name
            InputBasic(labelText: 'Prénom'),
            /// last name
            TextFormField(),
            /// address
            TextFormField(),
            /// codePost
            TextFormField(),
            /// city
            TextFormField(),
            /// phone number
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
