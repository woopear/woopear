import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';

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
    return Container();
  }
}
