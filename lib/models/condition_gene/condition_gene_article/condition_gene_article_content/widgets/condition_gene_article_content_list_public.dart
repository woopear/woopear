import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:woopear/models/condition_gene/condition_gene_article/condition_gene_article_content/condition_gene_article_content_state.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class ConditionGeneArticleContentListUpdate extends ConsumerStatefulWidget {
  String idConditionGene;
  String idArticle;

  ConditionGeneArticleContentListUpdate({
    Key? key,
    required this.idConditionGene,
    required this.idArticle,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneArticleContentListUpdateState();
}

class _ConditionGeneArticleContentListUpdateState
    extends ConsumerState<ConditionGeneArticleContentListUpdate> {
  @override
  Widget build(BuildContext context) {
    /// tuple pour les 2 id
    final ids = Tuple2(widget.idConditionGene, widget.idArticle);

    return Container(
      child: Column(
        children: [
          ref.watch(contentsOfArticleStream(ids)).when(
                data: (contents) {
                  return contents.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: contents.length,
                          itemBuilder: (context, index) {
                            final content = contents[index];
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// subtitle
                                  content.subTitle != null &&
                                          content.subTitle != ''
                                      ? buildSubTitle(
                                          subTitle: content.subTitle!,
                                        )
                                      : Container(),

                                  /// text
                                  buildText(text: content.text),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(
                          child: const Text('Aucun paragraphe'),
                        );
                },
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              ),
        ],
      ),
    );
  }

  /// subtitle
  Widget buildSubTitle({required String subTitle}) => Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Text(
              subTitle,
              style: const TextStyle().copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      );

  /// text du content
  Widget buildText({required String text}) => Container(
        margin: const EdgeInsets.only(
          top: 30.0,
        ),
        child: Column(
          children: [Text(text, textAlign: TextAlign.justify,)],
        ),
      );
}
