import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class AppBarBasic extends ConsumerStatefulWidget with PreferredSizeWidget {
  String text;
  bool automaticallyImplyLeading;
  bool seeConnexion;

  AppBarBasic(
      {Key? key,
      required this.text,
      required this.automaticallyImplyLeading,
      required this.seeConnexion})
      : super(key: key);

  @override
  _AppBarFlutooState createState() => _AppBarFlutooState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarFlutooState extends ConsumerState<AppBarBasic> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: Text(widget.text),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              ref.watch(userCurrentStream).when(
                    data: (data) {
                      if (widget.seeConnexion) {
                        return data != null
                            /// icon deconnection
                            ? IconButton(
                                onPressed: () async {
                                  /// petit load à la deconnection
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                  await ref.watch(userChange).disconnectUser();
                                  Navigator.pushNamed(context, Routes().home);
                                },
                                icon: const Icon(Icons.logout),
                              )

                            /// icon connexion
                            : IconButton(
                                onPressed: () async {
                                  Navigator.pushNamed(
                                      context, Routes().appAcces);
                                },
                                icon: const Icon(Icons.person_rounded),
                              );
                      } else {
                        return Container();
                      }
                    },
                    error: (error, stack) => const WaitingError(),
                    loading: () => const WaitingData(),
                  ),

              ///switch mode dark
              const WooThemeSwitch(
                iconFalse: Icon(Icons.dark_mode_outlined),
                iconTrue: Icon(Icons.light_mode_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
