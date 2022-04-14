import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/widgets/condition_gene_form.dart';
import 'package:woopear/widget_shared/container_basic.dart';

class ConditionGeneCreate extends ConsumerStatefulWidget {
  const ConditionGeneCreate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneCreateState();
}

class _ConditionGeneCreateState extends ConsumerState<ConditionGeneCreate> {
  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;
    
    return ContainerBasic(
      width: _width > 700 ? 600 : double.infinity,
      margin: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          /// formulaire
          ConditionGeneForm(btnTitle: 'CREER',),
        ],
      )
    );
  }
}
