import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/models/presentation/widgets/presentation_list/presentation_list_item.dart';
import 'package:woopear/models/presentation/widgets/presentation_list/title.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class PresentationList extends ConsumerStatefulWidget {
  const PresentationList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationListState();
}

class _PresentationListState extends ConsumerState<PresentationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          /// title de la page
          buildTitleListPresentation(),

          /// liste de presentation
          ref.watch(allPresentationStream).when(
                data: (presentations) {
                  /// si pas vide
                  if (presentations.isNotEmpty) {
                    /// on retourne liste des presentations
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: presentations.length,
                      itemBuilder: (context, index) {
                        return PresentationListItem(item: presentations[index]);
                      },
                    );
                  } else {
                    /// on affiche text de remplacement si le tableau est vide
                    return ContainerBasic(
                      child: const Text('Aucune présentation ajoutez en une !'),
                    );
                  }
                },
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              )
        ],
      ),
    );
  }
}
