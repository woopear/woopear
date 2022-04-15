import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_schema.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_state.dart';
import 'package:woopear/models/footer/footer_schema.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class FooterMenuListUpdate extends ConsumerStatefulWidget {
  FooterSchema footer;

  FooterMenuListUpdate({Key? key, required this.footer}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FooterMenuListUpdateState();
}

class _FooterMenuListUpdateState extends ConsumerState<FooterMenuListUpdate> {
  TextEditingController _libelle = TextEditingController(text: '');
  TextEditingController _url = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _libelle.dispose();
    _url.dispose();
    super.dispose();
  }

  Future<void> updateMenu(String idFooterMenu) async {
    if (_formKey.currentState!.validate()) {
      ///creation update footer menu
      final newFooterMenu =
          FooterMenuSchema(libelle: _libelle.text, url: _url.text);

      /// update bdd
      await ref
          .watch(footerMenuChange)
          .updateFooterMenu(widget.footer.id!, idFooterMenu, newFooterMenu);

      /// notification succes
      NotificationBasic(
        text: "Modification de l'item réussis",
        error: false,
      ).notification(context);
    } else {
      /// notification succes
      NotificationBasic(
        text: "Impossible de modifier l'item",
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le stream de tous les FooterMenu
    final footerMenus = ref.watch(footerMenusStream(widget.footer.id!));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            footerMenus.when(
              data: (menus) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    final menu = menus[index];
                    _libelle = TextEditingController(text: menu.libelle);
                    _url = TextEditingController(text: menu.url);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        children: [
                          /// title avec id
                          buildTitleItemMenu('Item : ${index + 1}',
                              widget.footer.id!, menu.id!),

                          /// input libelle
                          InputBasic(
                            labelText: 'Libelle',
                            controller: _libelle,
                            validator: (value) =>
                                WooValidator.validatorInputTextBasic(
                              textError: 'Champ obligatoire',
                              value: value,
                            ),
                          ),

                          /// input url
                          InputBasic(
                            labelText: 'url',
                            controller: _url,
                            validator: (value) =>
                                WooValidator.validatorInputTextBasic(
                              textError: 'Champ obligatoire',
                              value: value,
                            ),
                          ),

                          /// btn enregistrer
                          BtnElevatedBasic(
                            margin: const EdgeInsets.only(top: 30.0),
                            onPressed: () async {
                              await updateMenu(menu.id!);
                            },
                            textBtn: "ENREGISTRER L'ITEM",
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              error: (error, stack) => const WaitingError(),
              loading: () => const WaitingData(),
            ),
          ],
        ),
      ),
    );
  }

  /// title de l'item du menu
  Widget buildTitleItemMenu(
      String title, String idFooter, String idFooterMenu) {
    return Container(
      child: Row(
        children: [
          /// title
          Text(title),

          /// btn supprimer
          Tooltip(
            message: 'Supprimer item',
            child: IconButton(
              onPressed: () async {
                /// delete menu avec son id
                await ref
                    .watch(footerMenuChange)
                    .deleteFooterMenu(idFooter, idFooterMenu);
              },
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
