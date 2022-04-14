import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/widgets/content_gene_article_content_update/content_gene_article_content_update.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/widgets/condition_gene_article_label.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneArticleUpdateForm extends ConsumerStatefulWidget {
  ConditionGeneArticleSchema article;
  String idConditionGene;

  ConditionGeneArticleUpdateForm({
    Key? key,
    required this.article,
    required this.idConditionGene,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneArticleUpdateFormState();
}

class _ConditionGeneArticleUpdateFormState
    extends ConsumerState<ConditionGeneArticleUpdateForm> {
  TextEditingController _titleArticle = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleArticle.dispose();
    super.dispose();
  }

  /// modification de l'article et d'un content
  Future<void> updateArticleAndContent() async {
    try {
      /// creation article
      final newArticle = ConditionGeneArticleSchema(
        title: _titleArticle.text.trim(),
      );

      /// update dans bdd article
      await ref.watch(conditionGeneArticleChange).updateArticleOfConditionGene(
            widget.idConditionGene,
            widget.article.id!,
            newArticle,
          );

      NotificationBasic(
        text: "Article modifier avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      NotificationBasic(
        text: "Impossible de modifier l'article",
        error: true,
      ).notification(context);
    }
  }

  /// suppression de l'article te de tous ses contents
  Future<void> deleteArticle() async {
    try {
      await ref.watch(conditionGeneArticleChange).deleteArticleOfConditionGene(
            widget.idConditionGene,
            widget.article.id!,
          );
      NotificationBasic(
        text: "Article supprimer avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      NotificationBasic(
        text: "Impossible de supprimer l'article",
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _titleArticle = TextEditingController(text: widget.article.title);
    Tuple2<String, String> ids =
        Tuple2(widget.idConditionGene, widget.article.id!);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      margin: const EdgeInsets.only(top: 50.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          /// title article + btn delete + btn valider
          Row(
            children: [
              buildArticleLabel(widget.article.title, context),
              Tooltip(
                message: "Valider les modifications de l'article",
                child: IconButton(
                  onPressed: () async {
                    await updateArticleAndContent();
                  },
                  icon: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message: "Supprimer l'article",
                    child: IconButton(
                      onPressed: () async {
                        await deleteArticle();
                      },
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// formulaire
          Form(
            key: _formKey,
            child: Column(
              children: [
                /// input tile
                InputBasic(
                  labelText: "Titre de l'article",
                  controller: _titleArticle,
                ),
              ],
            ),
          ),

          /// list de content avec update
          ref.watch(contentsOfArticleStream(ids)).when(
                data: (contents) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: contents.length,
                    itemBuilder: (context, index) {
                      return ConditionGeneArticleContentUpdate(
                        idConditionGene: widget.idConditionGene,
                        content: contents[index],
                        idArticle: widget.article.id!,
                        index: index + 1
                      );
                    },
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
