import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_state.dart';
import 'package:woopear/models/footer/footer_state.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/widget_shared/waiting_data.dart';

class Footer extends ConsumerStatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterState();
}

class _FooterState extends ConsumerState<Footer> {
  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur
    final _width = MediaQuery.of(context).size.width;

    /// si mode dark ou pas
    bool idModeDark = Theme.of(context).brightness == Brightness.dark;

    /// on recupere le footer
    final footer = ref.watch(footerProvider);

    /// on recupere la presentation
    final presentation = ref.watch(presentationSelectProvider);

    /// on recupere le stream de tous les FooterMenu
    final footerMenus = ref.watch(footerMenusProvider);

    return Container(
      color: idModeDark ? const Color(0XFF363636) : const Color(0XFFF5F5F5),
      padding: EdgeInsets.only(
        left: _width > 950 ? 250 : 30.0,
        right: _width > 950 ? 250 : 30.0,
        top: 70.0,
        bottom: 20.0,
      ),
      child: SizedBox(
        child: Column(
          children: [
            /// brand + menu
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// brand
                presentation != null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 60.0),
                        width: _width > 700 ? 250.0 : 150.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              presentation.title,
                              style: const TextStyle()
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              presentation.info!,
                              textAlign: TextAlign.justify,
                              style: const TextStyle().copyWith(fontSize: 14.0),
                            )
                          ],
                        ),
                      )
                    : const WaitingData(),

                /// menu
                footerMenus != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: footerMenus.map((menu) {
                          return Container(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, menu.url);
                              },
                              child: Text(
                                menu.libelle,
                                style:
                                    const TextStyle().copyWith(fontSize: 14.0),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : const WaitingData(),
              ],
            ),

            Container(
              child: footer != null
                  ? Text(
                      '© ${footer.copyright} - ${DateTime.now().year}',
                      style: const TextStyle().copyWith(fontSize: 14.0),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
