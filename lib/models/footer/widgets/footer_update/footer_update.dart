import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/footer/widgets/footer_form.dart';
import 'package:woopear/models/footer/widgets/footer_title.dart';

class FooterUpdate extends ConsumerStatefulWidget {
  const FooterUpdate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterUpdateState();
}

class _FooterUpdateState extends ConsumerState<FooterUpdate> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          /// title + subTitle
          buildTitleCreateFooter(
            title: 'Modifier le footer',
            subTitle:
                "Modifier le copyright ou ajouter, modifier, supprimer des liens de menu.",
          ),

          /// formulaire
          FooterForm(titleBtn: 'MODIFIER', addMenu: true),
        ],
      ),
    );
  }
}
