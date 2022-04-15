import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/footer/widgets/footer_form.dart';
import 'package:woopear/models/footer/widgets/footer_title.dart';

class FooterCreate extends ConsumerStatefulWidget {
  const FooterCreate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterCreateState();
}

class _FooterCreateState extends ConsumerState<FooterCreate> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          /// title + subTitle
          buildTitleCreateFooter(
            title: 'Créer un footer',
            subTitle: "Aucun footer n'a été trouvé",
          ),

          /// formulaire
          FooterForm(titleBtn: 'CREER'),
        ],
      ),
    );
  }
}
