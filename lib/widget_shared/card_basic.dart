import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/utils/constants/globals.dart';

class CardBasic extends ConsumerWidget {
  Widget? child;
  CardBasic({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        padding: _width > 700
          ? EdgeInsets.all(Globals.paddingInterrieurCardPc)
          : EdgeInsets.all(Globals.paddingInterrieurCardMobile),
        child: child,
      ),
    );
  }
}