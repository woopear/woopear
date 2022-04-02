import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/widgets/signup/signup_form.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  @override
  Widget build(BuildContext context) {
  double _width = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: _width > 700 ? 700.0 : double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            /// formulaire de creation
            SignupForm(),
          ],
        )
      ),
    );
  }
}
