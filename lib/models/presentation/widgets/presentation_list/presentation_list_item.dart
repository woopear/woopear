import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/pages/private/presentation/presentation_modify.dart';

class PresentationListItem extends ConsumerStatefulWidget {
  PresentationSchema item;
  PresentationListItem({Key? key, required this.item}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationListItemState();
}

class _PresentationListItemState extends ConsumerState<PresentationListItem> {
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
            child: Text(
              widget.item.title != ''
                  ? widget.item.title
                  : 'Pas encore de titre',
              style: const TextStyle().copyWith(fontSize: 14.0),
            ),
          ),

          /// action
          /// voir
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PresentationModify(idPresentation: widget.item.id!),
                ),
              );
            },
            icon: const Icon(Icons.edit_note_rounded),
          ),

          ///suppression
          IconButton(
            onPressed: () async {
              await ref
                  .watch(presentationChange)
                  .deletePresentation(widget.item.id!);
            },
            icon: const Icon(Icons.delete_rounded, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
