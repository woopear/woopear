import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Container();
  }
}
