import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/utils/config/routes.dart';
import 'package:woopear/widget_shared/waiting_data.dart';

class PresentationDisplay extends ConsumerStatefulWidget {
  const PresentationDisplay({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationDisplayState();
}

class _PresentationDisplayState extends ConsumerState<PresentationDisplay> {
  @override
  Widget build(BuildContext context) {
    /// on recupere la presentation
    final presentation = ref.watch(presentationSelectProvider);

    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(
          left: 30.0, right: 30.0, top: 50.0, bottom: 80.0),
      child: presentation != null
          ? Column(
              children: [
                SizedBox(
                  width: _width > 700 ? 800 : double.infinity,
                  child: Column(
                    crossAxisAlignment: _width > 700
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      /// image
                      Align(
                        alignment: _width > 700
                            ? Alignment.centerLeft
                            : Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 40.0),
                          child: Image.network(
                            presentation.image!,
                            alignment: _width > 700
                                ? Alignment.centerLeft
                                : Alignment.center,
                            width: double.infinity,
                            height: _width > 700 ? 250 : 200,
                          ),
                        ),
                      ),

                      /// title
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0, top: 30.0),
                        child: Text(
                          presentation.title,
                          style: const TextStyle().copyWith(
                            fontSize: _width > 700 ? 80.0 : 60.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      /// sub title
                      Container(
                        margin: const EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          presentation.subTitle!,
                          textAlign:
                              _width > 700 ? TextAlign.left : TextAlign.center,
                          style: const TextStyle()
                              .copyWith(fontWeight: FontWeight.w100),
                        ),
                      ),

                      /// btn en savoir plus
                      Align(
                        alignment: _width > 700
                            ? Alignment.centerRight
                            : Alignment.center,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes().presentationDetail);
                            },
                            label: const Text(
                              'En savoir plus',
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const WaitingData(),
    );
  }
}
