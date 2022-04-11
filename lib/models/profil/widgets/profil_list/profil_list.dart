import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/widgets/profil_list/profil_list_item.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ProfilList extends ConsumerStatefulWidget {
  const ProfilList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilListState();
}

class _ProfilListState extends ConsumerState<ProfilList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      constraints: const BoxConstraints(maxHeight: 500.0),
      child: Column(children: [
        /// title
        Container(
          margin: const EdgeInsets.only(bottom: 50.0),
          child: const SubTitlePageAuth(text: 'Liste des clients'),
        ),

        /// liste clients
        ref.watch(allProfilsStream).when(
              data: (profils) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: profils!.length,
                  itemBuilder: (context, index) {
                    return ProfilListItem(item: profils[index]!);
                  },
                );
              },
              error: (error, stack) => const WaitingError(),
              loading: () => const WaitingData(),
            ),
      ]),
    );
  }
}
