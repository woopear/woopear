import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_state.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class ConditionGeneForm extends ConsumerStatefulWidget {
  ConditionGeneSchema? conditionGene;
  String btnTitle;

  ConditionGeneForm({Key? key, this.conditionGene, required this.btnTitle})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneFormState();
}

class _ConditionGeneFormState extends ConsumerState<ConditionGeneForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController(text: '');

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.conditionGene?.title ?? '');
  }

  /// reset form
  void resetInput() {
    _formKey.currentState!.reset();
    _title.clear();
  }

  /// create condition gene
  Future<void> createConditionGene(BuildContext context) async {
    try {
      /// creation de la condition gene
      final newConditionGene = ConditionGeneSchema(title: _title.text);

      /// creation en BDD
      await ref.watch(conditionGeneChange).addConditionGene(newConditionGene);

      /// message de succes
      NotificationBasic(
        text: "Création condition avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      /// message error
      NotificationBasic(
        text: "Impossible de creer la condition",
        error: true,
      ).notification(context);
      log(e.toString());
    }
  }

  /// update condition gene
  Future<void> updateConditionGene(BuildContext context) async {
    try {
      /// creation de la condition gene
      final newConditionGene = ConditionGeneSchema(
        title: _title.text,
        date: widget.conditionGene!.date,
      );

      /// creation en BDD
      await ref
          .watch(conditionGeneChange)
          .updateConditionGene(widget.conditionGene!.id!, newConditionGene);

      /// message de succes
      NotificationBasic(
        text: "Condition modifiée avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      /// message error
      NotificationBasic(
        text: "Impossible de modifier la condition",
        error: true,
      ).notification(context);
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// input title
            InputBasic(
              labelText: 'Title de la condition *',
              controller: _title,
              validator: (value) => WooValidator.validatorInputTextBasic(
                textError: 'Titre obligatoire',
                value: value,
              ),
            ),

            /// btn enregistrer
            BtnElevatedBasic(
              margin: const EdgeInsets.only(top: 50.0),
              onPressed: () async {
                switch (widget.btnTitle) {
                  case 'CREER':
                    !_formKey.currentState!.validate()
                        ? NotificationBasic(
                            text: 'Impossible de créer la condition',
                            error: true,
                          ).notification(context)
                        : await createConditionGene(context);
                    break;
                  case 'MODIFIER':
                    !_formKey.currentState!.validate()
                        ? NotificationBasic(
                            text: 'Impossible de modifier la condition',
                            error: true,
                          ).notification(context)
                        : await updateConditionGene(context);
                    break;
                  default:
                }
              },
              textBtn: widget.btnTitle,
            ),

            /// text info form
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 70.0),
                child: Text(
                  '* Champ obligatoire',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
