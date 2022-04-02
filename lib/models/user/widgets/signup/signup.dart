import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/widgets/signup/signup_form.dart';
import 'package:woopear/widget_shared/title_page_auth.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            /// title
            TitlePageAuth(text: 'Creation user'),
            
            /// formulaire de creation
            SignupForm(),
          ],
        )
      ),
    );
  }
}
