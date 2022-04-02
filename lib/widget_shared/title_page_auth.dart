import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TitlePageAuth extends ConsumerWidget {
  final String text;
  const TitlePageAuth({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Text(text, style: Theme.of(context).textTheme.headline4,),
    );
  }
}
