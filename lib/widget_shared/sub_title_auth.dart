import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubTitlePageAuth extends ConsumerWidget {
  final String text;
  
  const SubTitlePageAuth({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 26.0),
      ),
    );
  }
}
