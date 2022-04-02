import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/widgets/signup/signup.dart';
import 'package:woopear/models/user/widgets/signin/signin.dart';

class John extends ConsumerStatefulWidget {
  const John({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JohnState();
}

class _JohnState extends ConsumerState<John> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                Signup(),
                Signin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
