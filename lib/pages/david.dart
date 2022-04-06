import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/content/widgets/content_cart.dart';

class David extends ConsumerStatefulWidget {
  const David({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DavidState();
}

class _DavidState extends ConsumerState<David> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ContentCart(idContent: 'mjJV1TmWOjyWqpyiyQFf')
              ],
            ),
          ),
        ),
      ),
    );
  }
}