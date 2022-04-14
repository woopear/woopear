import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/widgets/condition_gene_article_update/condition_gene_article_update.dart';
import 'package:woopear/models/condition_gene/condition_gene_state.dart';
import 'package:woopear/models/condition_gene/widgets/condition_gene_form.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';
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
  /// creation article et content
  Future<void> createArticleAndContent(BuildContext context) async {
    try {
      /// creation article
      final newArticle = ConditionGeneArticleSchema(title: '');

      /// create dans la bdd de l'article
      final article =
          await ref.watch(conditionGeneArticleChange).addArticleOfConditionGene(
                widget.idConditionGene!,
                newArticle,
              );

      if (article != null) {
        /// creation d'un content
        final newContent = ConditionGeneArticleContentSchema(text: '');

        /// creation du content dans la bdd
        await ref
            .watch(conditionGeneArticleContentChange)
            .addContentOfArticleOfConditionGene(
              widget.idConditionGene!,
              article.id,
              newContent,
            );
      } else {
        throw Exception("Impossible de creer l'article");
      }

      /// notification succes
      NotificationBasic(
        text: "Article créé avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      /// notification error
      NotificationBasic(
        text: "Impossible de creer l'article",
        error: true,
      ).notification(context);
      log(e.toString());
    }
  }

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
                    width: _width > 800 ? 800 : double.infinity,
                    margin: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        /// formulaire update condition gene
                        ConditionGeneForm(
                          btnTitle: 'MODIFIER',
                          conditionGene: conditionSelect,
                        ),

                        /// btn ajoute un article
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(top: 50.0),
                            child: TextButton.icon(
                              onPressed: () async {
                                await createArticleAndContent(context);
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Ajouter un article'),
                            ),
                          ),
                        ),

                        /// formulaire create / update article
                        /// + formulaire create / update content pour article
                        ConditionGeneArticleUpdate(
                            idConditionGene: conditionSelect.id!),
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
