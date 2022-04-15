import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/widgets/condition_gene_article_title_section.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/widgets/condition_gene_article_update/condition_gene_article_update_form.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneArticleUpdate extends ConsumerStatefulWidget {
  String idConditionGene;

  ConditionGeneArticleUpdate({
    Key? key,
    required this.idConditionGene,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneArticleUpdateState();
}

class _ConditionGeneArticleUpdateState
    extends ConsumerState<ConditionGeneArticleUpdate> {
  @override
  Widget build(BuildContext context) {
    return ref
        .watch(articlesOfConditionGeneStream(widget.idConditionGene))
        .when(
          data: (articles) {
            return Container(
              child: Column(
                children: [
                  /// title
                  buildTitleSectionConditionGeneArticle(
                      "Section article", context),

                  articles.isNotEmpty
                      ?

                      /// liste des articles avec input
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return ConditionGeneArticleUpdateForm(
                              idConditionGene: widget.idConditionGene,
                              article: articles[index],
                            );
                          },
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 40.0),
                          child: const Text('Aucun article'),
                        )
                ],
              ),
            );
          },
          error: (error, stack) => const WaitingError(),
          loading: () => const WaitingData(),
        );
  }
}
