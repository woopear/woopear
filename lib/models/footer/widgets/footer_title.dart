import 'package:flutter/material.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';
import 'package:woopear/widget_shared/title_page_auth.dart';

Widget buildTitleCreateFooter(
        {required String title, required String subTitle}) =>
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitlePageAuth(text: title),
          SubTitlePageAuth(text: subTitle),
        ],
      ),
    );
