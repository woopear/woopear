import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_schema.dart';
import 'package:woopear/models/footer/footer_menu/footer_menu_state.dart';
import 'package:woopear/models/footer/footer_menu/widgets/footer_menu_list_update.dart';
import 'package:woopear/models/footer/footer_schema.dart';
import 'package:woopear/models/footer/footer_state.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class FooterForm extends ConsumerStatefulWidget {
  String titleBtn;
  bool addMenu;

  FooterForm({Key? key, required this.titleBtn, this.addMenu = false})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FooterFormState();
}

class _FooterFormState extends ConsumerState<FooterForm> {
  TextEditingController _copy = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();
  FooterSchema? footer;

  @override
  void dispose() {
    _copy.dispose();
    super.dispose();
  }

  /// reset input form
  void resetInput() {
    _formKey.currentState!.reset();
    _copy.clear();
  }

  /// creation d'un footer menu
  Future<void> createFooterMenu(String idFooter) async {
    final newFooterMenu = FooterMenuSchema(libelle: '', url: '');

    /// creation dans la BDD
    await ref.watch(footerMenuChange).addFooterMenu(idFooter, newFooterMenu);
  }

  /// creation d'un footer
  Future<void> createFooter() async {
    if (_formKey.currentState!.validate()) {
      final newFooter = FooterSchema(copyright: _copy.text);

      /// creation en BDD
      await ref.watch(footerChange).addFooter(newFooter);

      /// TODO : message succes
    } else {
      /// TODO : message error
    }
  }

  /// update d'un footer
  Future<void> updateFooter(String idFooter) async {
    print('FOOTER ID :::::::::: $idFooter');
    if (_formKey.currentState!.validate()) {
      final newFooter = FooterSchema(copyright: _copy.text);

      /// update en BDD
      await ref.watch(footerChange).updateFooter(idFooter, newFooter);

      /// TODO : message succes
    } else {
      /// TODO : message error
    }
  }

  @override
  Widget build(BuildContext context) {
    final footer = ref.watch(footerProvider);

    /// si footer existe (dans le cas de update)
    footer != null
        ? _copy = TextEditingController(text: footer.copyright)
        : _copy = TextEditingController(text: '');

    return ContainerBasic(
      margin: const EdgeInsets.only(top: 70.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                /// input copyright
                InputBasic(
                  labelText: 'Copyright *',
                  controller: _copy,
                  validator: (value) => WooValidator.validatorInputTextBasic(
                    textError: 'Champ obligatoire',
                    value: value,
                  ),
                ),

                /// si addMenu est true
                widget.addMenu
                    ? Container(
                        child: Column(
                          children: [
                            /// btn ajouter menu
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 50.0, bottom: 20.0),
                                child: TextButton.icon(
                                  onPressed: () async {
                                    await createFooterMenu(footer!.id!);
                                  },
                                  icon: const Icon(Icons.add),
                                  label: const Text('Ajouter un menu'),
                                ),
                              ),
                            ),

                            footer != null
                                ? FooterMenuListUpdate(footer: footer)
                                : Container(),
                          ],
                        ),
                      )
                    : Container(),

                /// btn creer
                BtnElevatedBasic(
                  margin: const EdgeInsets.only(top: 40.0),
                  onPressed: () async {
                    if (widget.titleBtn == 'CREER') {
                      await createFooter();
                    } else {
                      footer != null ? await updateFooter(footer.id!) : null;
                    }
                  },
                  textBtn: widget.titleBtn,
                ),

                /// text info formulaire
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    child: Text(
                      '* Champ obligatoire',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
