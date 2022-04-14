import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_state.dart';
import 'package:woopear/models/condition_gene/widgets/condition_gene_update/condition_gene_update.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';
import 'package:woopear/widget_shared/waiting_data.dart';

class ConditionGeneModify extends ConsumerStatefulWidget {
  String? idConditionSelected;
  ConditionGeneModify({Key? key, this.idConditionSelected}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneModifyState();
}

class _ConditionGeneModifyState extends ConsumerState<ConditionGeneModify> {
  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    /// ecoute le doc condition selectionné
    final conditionGeneSelected =
        ref.watch(conditionGeneSelectedProvider(widget.idConditionSelected!));

    return SafeArea(
      child: Scaffold(
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text:
              conditionGeneSelected != null ? conditionGeneSelected.title : '',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                /// title page
                conditionGeneSelected != null
                    ? buildTitleConditionGene(
                        title:
                            'Modification de ${conditionGeneSelected.title} du ${conditionGeneSelected.date!.toDate().day < 10 ? '0${conditionGeneSelected.date!.toDate().day}' : '${conditionGeneSelected.date!.toDate().day}'}/${conditionGeneSelected.date!.toDate().month < 10 ? '0${conditionGeneSelected.date!.toDate().month}' : '${conditionGeneSelected.date!.toDate().month}'}/${conditionGeneSelected.date!.toDate().year}',
                      )
                    : const WaitingData(),

                /// update
                ConditionGeneUpdate(
                    idConditionGene: widget.idConditionSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// title des page condition gene private
  Widget buildTitleConditionGene({
    String? subTitle,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0, bottom: 70.0),
      child: Column(
        children: [
          /// title
          Container(
            child: SubTitlePageAuth(text: title),
          ),

          /// sub title
          subTitle != null
              ? Text(
                  subTitle,
                  style: const TextStyle().copyWith(fontSize: 16.0),
                )
              : Container(),
        ],
      ),
    );
  }
}
