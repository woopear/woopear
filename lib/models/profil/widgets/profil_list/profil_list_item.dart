import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';

class ProfilListItem extends ConsumerStatefulWidget {
  ProfilSchema item;
  ProfilListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilListItemState();
}

class _ProfilListItemState extends ConsumerState<ProfilListItem> {
  Future<void> deleteProfilAndUser(String idProfil) async {
    await ref.watch(profilChange).deleteProfil(idProfil);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          /// nom prenom
          Expanded(
            child: Text(widget.item.firstName + ' ' + widget.item.lastName),
          ),

          /// action
          /// voir
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.visibility_rounded),
          ),

          ///modification
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_rounded,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),

          ///suppression
          IconButton(
            onPressed: () async {
              await deleteProfilAndUser(widget.item.id!);
            },
            icon: const Icon(Icons.delete_rounded, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
