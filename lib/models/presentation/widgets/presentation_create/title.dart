import 'package:flutter/cupertino.dart';
import 'package:woopear/models/presentation/presentation_const.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';

Widget buildTitleCreatePresentation() {
  return Container(
    margin: const EdgeInsets.only(top: 50.0, bottom: 50.0),
    child: SubTitlePageAuth(text: PresentationConst.creationPresentationTitle,),
  );
}
