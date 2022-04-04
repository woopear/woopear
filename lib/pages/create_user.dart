import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/widgets/signup/signup.dart';

class CreateUser extends ConsumerStatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Create_userState();
}

class _Create_userState extends ConsumerState<CreateUser> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                /// creation utilisateur
                Signup(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
