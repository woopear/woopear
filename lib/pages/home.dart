import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/contact/widgets/contact_partial.dart';
import 'package:woopear/models/presentation/widgets/presentation_display/presentation_display.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    /// si mode dark ou pas
    bool idModeDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarBasic(
          seeConnexion: true,
          text: 'woopear',
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                /// presentation
                Container(
                  width: double.infinity,
                  color: idModeDark ? const Color(0XFF363636) : const Color(0XFFF5F5F5),
                  child: const PresentationDisplay(),
                ),  
                
                /// affichage partie contact (envoie mail + info woopear) 
                const ContactPartial(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
