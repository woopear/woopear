import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContainerBasic extends ConsumerWidget {
  Widget child;
  EdgeInsetsGeometry? margin;
  double? width;

  ContainerBasic({Key? key, required this.child, this.margin, this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// si mode dark ou pas
    bool idModeDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(40.0),
      width: width,
      decoration: BoxDecoration(
        color: idModeDark ? const Color(0XFF363636) : const Color(0XFFF5F5F5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: child,
    );
  }
}
