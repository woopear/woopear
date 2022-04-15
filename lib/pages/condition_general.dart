import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/widgets/condition_gene_article_list_public.dart';
import 'package:woopear/models/condition_gene/condition_gene_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_state.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneral extends ConsumerStatefulWidget {
  const ConditionGeneral({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneralState();
}

class _ConditionGeneralState extends ConsumerState<ConditionGeneral> {
  ConditionGeneSchema? condition;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarBasic(
          seeConnexion: false,
          text: 'Conditions générales',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    ref.watch(conditionGenesActivateStream).when(
                          data: (conditionGenes) {
                            if (conditionGenes.isNotEmpty) {
                              condition = conditionGenes[0];
                              date = condition!.date!.toDate();
                            }
                            return conditionGenes.isNotEmpty &&
                                    condition != null
                                ? SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        /// title
                                        buildTitle(
                                          title: condition!.title,
                                        ),

                                        /// date
                                        buildDateConditionGene(
                                          date:
                                              "du ${date!.day < 10 ? '0${date!.day}' : '${date!.day}'}/${date!.month < 10 ? '0${date!.month}' : '${date!.month}'}/${date!.year}",
                                        ),

                                        /// liste article
                                        ConditionGeneArticlListPublic(
                                          condition: condition!,
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 70.0),
                                      child: const Text(
                                          'Aucunes conditions générales activées'),
                                    ),
                                  );
                          },
                          error: (error, stack) => const WaitingError(),
                          loading: () => const WaitingData(),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// title de la page
  Widget buildTitle({required String title}) => Center(
        child: Container(
          margin: const EdgeInsets.only(top: 70.0),
          child: Text(
            title,
            style: const TextStyle().copyWith(
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );

  /// affichage de la date de creation des conditions
  Widget buildDateConditionGene({required String date}) => Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 90.0),
          child: Text(
            date,
            style: const TextStyle().copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      );
}
