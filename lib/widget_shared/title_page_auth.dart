import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitlePageAuth extends ConsumerWidget {
  final String text;
  
  const TitlePageAuth({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: _width > 700 ? Theme.of(context).textTheme.headline2 : Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
