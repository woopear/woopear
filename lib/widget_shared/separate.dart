import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Separate extends ConsumerWidget {
  EdgeInsetsGeometry? margin;
  Separate({Key? key, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: margin,
      child: Divider(color: Theme.of(context).colorScheme.secondary),
    );
  }
}
