import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_schema.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/widgets/condition_gene_article_label.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class ConditionGeneArticleContentUpdate extends ConsumerStatefulWidget {
  String idConditionGene;
  String idArticle;
  ConditionGeneArticleContentSchema content;
  int index;

  ConditionGeneArticleContentUpdate({
    Key? key,
    required this.idConditionGene,
    required this.content,
    required this.idArticle,
    required this.index,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneArticleContentUpdateState();
}

class _ConditionGeneArticleContentUpdateState
    extends ConsumerState<ConditionGeneArticleContentUpdate> {
  TextEditingController _subTitle = TextEditingController(text: '');
  TextEditingController _text = TextEditingController(text: '');
  final bool _validate = false;

  @override
  void dispose() {
    _subTitle.dispose();
    _text.dispose();
    super.dispose();
  }

  /// creation content
  Future<void> createContent() async {
    try {
      /// creation du content
      final newContent = ConditionGeneArticleContentSchema(text: '');

      /// creation du content dans la bdd
      await ref
          .watch(conditionGeneArticleContentChange)
          .addContentOfArticleOfConditionGene(
              widget.idConditionGene, widget.idArticle, newContent);

      NotificationBasic(
        text: "Paragraphe créé avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      NotificationBasic(
        text: "Impossible de créer un paragraphe",
        error: true,
      ).notification(context);
    }
  }

  /// modification du content
  Future<void> updateContent() async {
    try {
      /// creation du content
      final newContent = ConditionGeneArticleContentSchema(
        text: _text.text.trim(),
        subTitle: _subTitle.text.trim(),
      );

      /// creation du content dans la bdd
      await ref
          .watch(conditionGeneArticleContentChange)
          .updateContentOfArticleOfConditionGene(widget.idConditionGene,
              widget.idArticle, widget.content.id!, newContent);

      NotificationBasic(
        text: "Paragraphe modifier avec succès",
        error: false,
      ).notification(context);
    } catch (e) {
      NotificationBasic(
        text: "Impossible de modifier le paragraphe",
        error: true,
      ).notification(context);
    }
  }

  /// delete content
  Future<void> deleteContent() async {
    try {
      await ref
          .watch(conditionGeneArticleContentChange)
          .deleteContentOfArticleOfConditionGene(
              widget.idConditionGene, widget.idArticle, widget.content.id!);
    } catch (e) {
      NotificationBasic(
        text: "Impossible de supprimer le paragraphe",
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _subTitle = TextEditingController(text: widget.content.subTitle);
    _text = TextEditingController(text: widget.content.text);

    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Row(
            children: [
              /// label
              buildArticleLabel('Contenu : ${widget.index}', context),

              Tooltip(
                message: "Ajouter un paragraphe",
                child: IconButton(
                  onPressed: () async {
                    await createContent();
                  },
                  icon: const Icon(
                    Icons.add_circle_rounded,
                  ),
                ),
              ),

              Tooltip(
                message: "Valider les modifications du paragraphe",
                child: IconButton(
                  onPressed: () async {
                    await updateContent();
                  },
                  icon: const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                ),
              ),

              /// btn action
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message: "Supprimer le paragraphe",
                    child: IconButton(
                      onPressed: () async {
                        await deleteContent();
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

          /// input subtitle
          Container(
            child: InputBasic(
              labelText: 'Sous titre',
              controller: _subTitle,
            ),
          ),

          /// input text
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: TextField(
              style: GoogleFonts.nunito().copyWith(fontSize: 20.0),
              controller: _text,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Paragraphe",
                errorText: _validate ? "Veuillez remplir le champs" : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
