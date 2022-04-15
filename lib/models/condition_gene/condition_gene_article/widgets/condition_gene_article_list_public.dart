import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/widgets/condition_gene_article_content_list_public.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_state.dart';
import 'package:woopear/models/condition_gene/condition_gene_schema.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneArticlListPublic extends ConsumerStatefulWidget {
  ConditionGeneSchema condition;

  ConditionGeneArticlListPublic({
    Key? key,
    required this.condition,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneArticlListPublicState();
}

class _ConditionGeneArticlListPublicState
    extends ConsumerState<ConditionGeneArticlListPublic> {
  @override
  Widget build(BuildContext context) {
    
    final _width = MediaQuery.of(context).size.width;
    
    return SizedBox(
      width: _width > 850 ? 800 : double.infinity,
      child: Column(
        children: [
          /// list des articles
          ref.watch(articlesOfConditionGeneStream(widget.condition.id!)).when(
                data: (articles) {
                  return articles.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];

                            /// item article
                            return Container(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// titre de l'article
                                  buildTitle(article.title),

                                  /// list des contents
                                  ConditionGeneArticleContentListUpdate(
                                    idConditionGene: widget.condition.id!,
                                    idArticle: article.id!,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(
                          child: const Text('Aucun article'),
                        );
                },
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              ),
        ],
      ),
    );
  }

  Widget buildTitle(String title) => Container(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle().copyWith(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );
}
