import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/models/user/widgets/signin/signin.dart';
import 'package:woopear/models/dashbord/dashboard.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class AppAcces extends ConsumerStatefulWidget {
  const AppAcces({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConnexionState();
}

class _ConnexionState extends ConsumerState<AppAcces> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: ref.watch(userCurrentStream).when(
                    data: (user) {
                      if (user != null) {
                        /// dashboard
                        return const Dashboard();
                      } else {
                        /// formulaire de connexion
                        return const Signin();
                      }
                    },
                    error: (error, stack) => const WaitingError(),
                    loading: () => const WaitingData(),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
