import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
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

    /// si mode dark ou pas
    bool idModeDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0, bottom: 80.0),
      child: presentation != null
          ? Column(
              children: [
                /// entete de la presentation
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// image
                    Container(
                      margin: const EdgeInsets.only(top: 40.0),
                      child: Image.network(
                        presentation.image!,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),

                    /// title
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0, top: 30.0),
                      child: Text(
                        presentation.title,
                        style: const TextStyle().copyWith(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// sub title
                    Container(
                      margin: const EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        presentation.subTitle!,
                        textAlign: TextAlign.center,
                        style: const TextStyle()
                            .copyWith(fontWeight: FontWeight.w100),
                      ),
                    ),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'En savoir plus',
                          ),
                          icon: const Icon(
                            Icons.keyboard_arrow_right,
                          )),
                    ),
                  ],
                )
              ],
            )
          : const WaitingData(),
    );
  }
}
