import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/models/presentation/widgets/presentation_create/label.dart';
import 'package:woopear/models/upload/upload_state.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class PresentationCreateForm extends ConsumerStatefulWidget {
  const PresentationCreateForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationCreateFormState();
}

class _PresentationCreateFormState
    extends ConsumerState<PresentationCreateForm> {
  final _formKey = GlobalKey<FormState>();

  /// input
  final TextEditingController _title = TextEditingController(text: '');
  final TextEditingController _subTitle = TextEditingController(text: '');
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _address = TextEditingController(text: '');
  final TextEditingController _codePost = TextEditingController(text: '');
  final TextEditingController _city = TextEditingController(text: '');
  final TextEditingController _phoneNumber = TextEditingController(text: '');
  final TextEditingController _infoSup = TextEditingController(text: '');

  /// pour image
  dynamic _file;
  String? _extention;
  String? _url;
  FilePickerResult? _picker;

  @override
  void dispose() {
    _title.dispose();
    _subTitle.dispose();
    _email.dispose();
    _address.dispose();
    _codePost.dispose();
    _city.dispose();
    _phoneNumber.dispose();
    _infoSup.dispose();
    super.dispose();
  }

  void resetInput() {
    setState(() {
      _picker = null;
      _file = null;
      _extention = null;
      _url = null;
      _formKey.currentState!.reset();
      _title.clear();
      _subTitle.clear();
      _email.clear();
      _address.clear();
      _codePost.clear();
      _city.clear();
      _phoneNumber.clear();
      _infoSup.clear();
    });
  }

  /// creation conteneur pour fichier
  Future<void> _selectImage() async {
    if (kIsWeb) {
      final file = await FilePicker.platform.pickFiles();
      setState(() {
        _picker = file;
      });
    } else {
      final file = await FilePicker.platform.pickFiles(allowMultiple: false);
      setState(() async {
        _picker = file;
      });
    }
  }

  /// upload image
  Future<void> _uploadImage() async {
    /// si web sinon le reste
    if (kIsWeb) {
      if (_picker == null) {
        /// notification error
        NotificationBasic(
          text: "Modification de l'image annulée",
          error: true,
        ).notification(context);
        throw Exception("Modification de l'image annulée");
      }

      /// on recupere le path
      setState(() {
        _file = _picker!.files.first.bytes;
        _extention = _picker!.files.first.extension;
      });

      _url = await ref
          .watch(uploadFileChange)
          .uploadImagePresentation(_file, extension: _extention!);
    } else {
      if (_picker == null) return;

      /// on recupere le fichier
      setState(() {
        _file = File(_picker!.files.single.path!);
      });

      _url = await ref.watch(uploadFileChange).uploadImagePresentation(_file);
    }
  }

  /// creation présentation
  Future<void> _creationPresentation(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      /// si input image contient une image
      /// on enregistre l'image et on recupere l'url
      if (_picker != null) {
        await _uploadImage();
      }

      /// creation objet PresentationSchema
      /// si url != null on met l'url dans image
      /// sinon on met ''
      final newPresentation = PresentationSchema(
        title: _title.text.trim(),
        phoneNumber: _phoneNumber.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        codePost: _codePost.text.trim(),
        city: _city.text.trim(),
        image: _url ?? '',
        info: _infoSup.text.trim(),
        subTitle: _subTitle.text.trim(),
      );

      /// creation bdd de la présentation
      await ref.watch(presentationChange).createPresentation(newPresentation);

      /// notification error
      NotificationBasic(
        text: 'Creation de la présentation réussis',
        error: false,
      ).notification(context);

      resetInput();
    } else {
      /// notification error
      NotificationBasic(
        text: 'Impossible de creer la présentation',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ContainerBasic(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// cadre info de base
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// label cadre
                      buildLabelPartieFormulairePresentation(
                        'Information de base',
                        null,
                        context,
                      ),

                      /// input title
                      InputBasic(
                        controller: _title,
                        labelText: 'Titre de la présentation *',
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputTitlePresentation,
                          value: value,
                        ),
                      ),

                      /// input sub title
                      InputBasic(
                        controller: _subTitle,
                        labelText: 'Sous titre de la présentation',
                      ),
                    ],
                  ),

                  /// cadre info entreprise
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// label cadre
                      buildLabelPartieFormulairePresentation(
                        'Information entreprise',
                        const EdgeInsets.only(top: 70.0),
                        context,
                      ),

                      /// input email
                      InputBasic(
                        controller: _email,
                        labelText: "Email de l'entreprise *",
                        validator: (value) => WooValidator.validateEmail(
                          textError: WooValidator.errorInputEmail,
                          value: value,
                        ),
                      ),

                      /// input addresse
                      InputBasic(
                        controller: _address,
                        labelText: 'Adresse *',
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputAddresse,
                          value: value,
                        ),
                      ),

                      /// input code postal
                      InputBasic(
                        controller: _codePost,
                        labelText: 'Code postal *',
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputCodePost,
                          value: value,
                        ),
                      ),

                      /// input ville
                      InputBasic(
                        controller: _city,
                        labelText: 'Ville *',
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputCity,
                          value: value,
                        ),
                      ),

                      /// input phoneNumber
                      InputBasic(
                        controller: _phoneNumber,
                        labelText: 'Numéro de téléphone *',
                        validator: (value) =>
                            WooValidator.validatorInputTextBasic(
                          textError: WooValidator.errorInputPhoneNumber,
                          value: value,
                        ),
                      ),
                    ],
                  ),

                  /// cadre info supplementaire
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// label cadre
                      buildLabelPartieFormulairePresentation(
                        'Information supplémentaire',
                        const EdgeInsets.only(top: 70.0),
                        context,
                      ),

                      /// input info
                      InputBasic(
                        controller: _infoSup,
                        labelText: 'Information supplémentaire',
                      )

                      /// input image
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 70.0),
                        child: _picker != null
                            ?

                            /// image de presentation
                            Image.memory(
                                _picker!.files.first.bytes!,
                                height: 100.0,
                                width: double.infinity,
                              )
                            : const Text("Pas d'image selectionnée"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40.0, top: 20.0),
                        child: _picker != null
                            ?

                            /// btn pour enlever image de présentation
                            TextButton.icon(
                                onPressed: () async {
                                  setState(() {
                                    _picker = null;
                                  });
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Supprimer image'),
                              )
                            : TextButton.icon(
                                onPressed: () async {
                                  await _selectImage();
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Ajouter une image'),
                              ),
                      ),
                    ],
                  ),

                  /// btn creer
                  BtnElevatedBasic(
                    margin: const EdgeInsets.only(top: 50.0),
                    onPressed: () async {
                      await _creationPresentation(context);
                    },
                    textBtn: 'CREER',
                  ),

                  /// text info formulaire
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 70.0),
                      child: Text(
                        '* Champs obligatoire',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
