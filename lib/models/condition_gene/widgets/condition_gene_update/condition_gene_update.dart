import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_state.dart';
import 'package:woopear/models/condition_gene/widgets/condition_gene_form.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneUpdate extends ConsumerStatefulWidget {
  String? idConditionGene;
  ConditionGeneUpdate({Key? key, this.idConditionGene}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneUpdateState();
}

class _ConditionGeneUpdateState extends ConsumerState<ConditionGeneUpdate> {
  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          ref
              .watch(
                conditionGeneStream(widget.idConditionGene!),
              )
              .when(
                data: (conditionSelect) {
                  return ContainerBasic(
                    width: _width > 700 ? 600 : double.infinity,
                    margin: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        /// formulaire update condition gene
                        ConditionGeneForm(
                          btnTitle: 'MODIFIER',
                          conditionGene: conditionSelect,
                        ),

                        /// formulaire create / update article
                        /// + formulaire create / update pour article
                      ],
                    ),
                  );
                },
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              ),
        ],
      ),
    );
  }
}
