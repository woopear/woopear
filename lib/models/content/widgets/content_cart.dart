import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/content/content_state.dart';

class ContentCart extends ConsumerStatefulWidget {
  String idContent;

  ContentCart({
    Key? key,
    required this.idContent,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentCartState();
}

class _ContentCartState extends ConsumerState<ContentCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(contentChange).streamContentById(widget.idContent);

    final content = ref.watch(contentStreamById(widget.idContent));

    return Container(
      /// les bordures du container
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          )),
      padding: const EdgeInsets.all(10),
      width: 200,
      child: Center(
        child: Column(
          children: [
            /// affichage du subTitle
            Container(
              child: content != null
                  ? Text(
                      content.subTitle!,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    )
                  : const Text('pas de donnée'),
            ),
            /// affichage du content
            Container(
              padding: const EdgeInsets.only(
                bottom: 10,
                left: 10,
                right: 10,
              ),
              child: content != null
                  ? Text(
                      content.content!,
                    )
                  : const Text('pas de donnée'),
            ),
          ],
        ),
      ),
    );
  }
}
