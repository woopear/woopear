import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_state.dart';
import 'package:woopear/pages/private/condition_gene/condition_gene_modify.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneList extends ConsumerStatefulWidget {
  const ConditionGeneList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneListState();
}

class _ConditionGeneListState extends ConsumerState<ConditionGeneList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ref.watch(conditionGenesStream).when(
                data: (conditionGenes) => conditionGenes.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: conditionGenes.length,
                        itemBuilder: (context, index) {
                          final conditionGene = conditionGenes[index];
                          final date = conditionGene.date!.toDate();
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  /// title condition
                                  cel1(conditionGene.title),

                                  /// date
                                  cel2(
                                      'du ${date.day < 10 ? '0${date.day}' : '${date.day}'}/${date.month < 10 ? '0${date.month}' : '${date.month}'}/${date.year}'),

                                  /// groupe btn action
                                  action(conditionGene),
                                ],
                              ));
                        },
                      )
                    : const Center(
                        child: SubTitlePageAuth(text: 'Aucune condition'),
                      ),
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              ),
        ],
      ),
    );
  }

  /// cellule 1
  Widget cel1(String text) => Expanded(
        child: Container(
          child: Text(
            text,
            style: const TextStyle().copyWith(fontSize: 14.0),
          ),
        ),
      );

  /// cellule 2
  Widget cel2(String text) => Container(
        child: Text(
          text,
          style: const TextStyle().copyWith(fontSize: 14.0),
        ),
      );

  /// cellule action regroupant les btns
  Widget action(ConditionGeneSchema conditionGene) => Container(
        padding: const EdgeInsets.only(left: 50.0, right: 10.0),
        child: Row(
          children: [
            /// btn activate
            IconButton(
              onPressed: () async {
                final newConditionGene = conditionGene;
                newConditionGene.activate = !newConditionGene.activate!;
                await ref.watch(conditionGeneChange).updateConditionGene(
                      conditionGene.id!,
                      newConditionGene,
                    );
              },
              icon: conditionGene.activate!
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.check_circle_outline,
                      color: Theme.of(context).disabledColor,
                    ),
            ),

            /// btn voir
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConditionGeneModify(
                        idConditionSelected: conditionGene.id!),
                  ),
                );
              },
              icon: const Icon(Icons.visibility_rounded),
            ),

            /// btn delete
            IconButton(
              onPressed: () async {
                await ref
                    .watch(conditionGeneChange)
                    .deleteConditionGene(conditionGene.id!);
              },
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ],
        ),
      );
}
