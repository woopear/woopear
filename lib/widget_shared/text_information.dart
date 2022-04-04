import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInfo extends ConsumerWidget {
  String text;
  TextInfo({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium,);
  }
}
