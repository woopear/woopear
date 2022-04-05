import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/content/content_state.dart';

class ContentCart extends ConsumerStatefulWidget {
  const ContentCart({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentCartState();
}

class _ContentCartState extends ConsumerState<ContentCart> {
  @override
  Widget build(BuildContext context) {
    final content = ref.watch(contentChange).content;
    return Container(
      child: Column(
        children: [
          Text(
            content.subTitle,
          ),
        ],
      ),
    );
  }
}
