import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';

class ConditionGeneral extends ConsumerStatefulWidget {
  const ConditionGeneral({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConditionGeneralState();
}

class _ConditionGeneralState extends ConsumerState<ConditionGeneral> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarBasic(
          seeConnexion: true,
          text: 'Conditions générales',
          automaticallyImplyLeading: true,
        ),
        body: const SingleChildScrollView(),
      ),
    );
  }
}
