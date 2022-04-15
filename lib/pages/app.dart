import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/models/user/widgets/signin/signin.dart';
import 'package:woopear/models/dashbord/dashboard.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';
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
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;
    
    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: user != null ? 'Tableau de bord' : 'Connexion',
          automaticallyImplyLeading: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: ref.watch(userCurrentStream).when(
                    data: (user) {
                      if (user != null) {
                        /// dashboard
                        return const Dashboard();
                      } else {
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
