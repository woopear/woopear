import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/widgets/presentation_create/presentation_create_form.dart';
import 'package:woopear/models/presentation/widgets/presentation_create/title.dart';

class PresentationCreate extends ConsumerStatefulWidget {
  const PresentationCreate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PresentationCreateState();
}

class _PresentationCreateState extends ConsumerState<PresentationCreate> {

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _width > 700 ? 600.0 : double.infinity,
      child: Column(
        children: [
          /// title 
          buildTitleCreatePresentation(),
          
          /// form create
          const PresentationCreateForm(),
        ],
      ),
    );
  }
}