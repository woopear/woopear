import 'package:flutter/material.dart';
import 'package:woopear/pages/home.dart';

class Routes {
  String home = '/';

  Map<String, Widget Function(BuildContext)> urls() {
    return {
      '/': (context) => const Home(),
    };
  }
}