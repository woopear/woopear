import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_const.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/models/presentation/widgets/presentation_update/presentation_update.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';

class PresentationModify extends ConsumerStatefulWidget {
  String idPresentation;

  PresentationModify({
    Key? key,
    required this.idPresentation,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationModifyState();
}

class _PresentationModifyState extends ConsumerState<PresentationModify> {
  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    /// on ecoute la présentation selectionné
    ref.watch(presentationChange).streamPresentationUpdate(widget.idPresentation);

    return SafeArea(
      child: Scaffold(
        //drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: PresentationConst.pageUpdatePresentationTitle,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                /// presentation update
                PresentationUpdate(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
