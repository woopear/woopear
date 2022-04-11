import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_const.dart';
import 'package:woopear/models/presentation/presentation_content/presentation_content_schema.dart';
import 'package:woopear/models/presentation/presentation_content/presentation_content_state.dart';
import 'package:woopear/models/presentation/presentation_schema.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/models/presentation/widgets/presentation_create/label.dart';
import 'package:woopear/models/presentation/widgets/presentation_update/presentation_update_list_content.dart';
import 'package:woopear/models/presentation/widgets/presentation_update/title.dart';
import 'package:woopear/models/upload/upload_state.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';
import 'package:woopear/widget_shared/separate.dart';
import 'package:woopear/widget_shared/waiting_data.dart';
import 'package:woopear/widget_shared/waiting_error.dart';

class PresentationUpdate extends ConsumerStatefulWidget {
  const PresentationUpdate({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationUpdateState();
}

class _PresentationUpdateState extends ConsumerState<PresentationUpdate> {
  final _formKey = GlobalKey<FormState>();

  /// input
  TextEditingController _title = TextEditingController(text: '');
  TextEditingController _subTitle = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _address = TextEditingController(text: '');
  TextEditingController _codePost = TextEditingController(text: '');
  TextEditingController _city = TextEditingController(text: '');
  TextEditingController _phoneNumber = TextEditingController(text: '');
  TextEditingController _infoSup = TextEditingController(text: '');

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

  /// reset input
  void resetInput() {
    _formKey.currentState!.reset();
    _file = null;
    _extention = null;
    _url = null;
    _picker = null;
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
          text: PresentationConst.creationPresentationMessagePickerNull,
          error: true,
        ).notification(context);
        throw Exception(
            PresentationConst.creationPresentationMessagePickerNull);
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

  /// update image en directe BDD
  Future<void> _updateImageDirectly(PresentationSchema oldPresentation) async {
    if (_formKey.currentState!.validate()) {
      /// selection image
      await _selectImage();

      /// upload image
      await _uploadImage();

      /// creation de la presentationSchema
      final newPresentation = oldPresentation;
      newPresentation.image = _url ?? '';

      /// update presentation
      await ref.watch(presentationChange).updatePresentation(newPresentation);

      /// notif succes
      NotificationBasic(
        text: 'Image modifier avec succes',
        error: false,
      ).notification(context);

      resetInput();
    } else {
      /// notif succes
      NotificationBasic(
        text: "Impossible de modifier l'image, vérifier les champs obligatoire",
        error: false,
      ).notification(context);
    }
  }

  /// suppression image
  Future<void> _deleteImageDirectly(PresentationSchema oldPresentation) async {
    if (_formKey.currentState!.validate()) {
      /// supprimer proprieter image dans présentation
      final newPresentation = oldPresentation;
      newPresentation.image = '';
      await ref.watch(presentationChange).updatePresentation(newPresentation);

      /// suppression de l'image dans storage
      await ref
          .watch(uploadFileChange)
          .deleteImage('presentation/pres-woopear');

      /// notif succes
      NotificationBasic(
        text: 'Image supprimer avec succès',
        error: false,
      ).notification(context);

      resetInput();
    } else {
      /// notif succes
      NotificationBasic(
        text:
            "Impossible de supprimer l'image, veuillez vérifier les champs obligatoire",
        error: true,
      ).notification(context);
    }
  }

  /// update présentation
  Future<void> _updatePresentation(PresentationSchema oldPresentation) async {
    if (_formKey.currentState!.validate()) {
      /// creation objet PresentationSchema
      final newPresentation = PresentationSchema(
        id: oldPresentation.id,
        title: _title.text.trim(),
        phoneNumber: _phoneNumber.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        codePost: _codePost.text.trim(),
        city: _city.text.trim(),
        image: oldPresentation.image,
        info: _infoSup.text.trim(),
        subTitle: _subTitle.text.trim(),
      );

      /// creation bdd de la présentation
      await ref.watch(presentationChange).updatePresentation(newPresentation);

      /// notification succes
      NotificationBasic(
        text: 'Présentation modifier',
        error: false,
      ).notification(context);

      resetInput();
    } else {
      /// notification error
      NotificationBasic(
        text: 'Impossible de modifier la présentation',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          /// title
          buildTitleUpdatePresentation(),

          /// ecoute de la présentation selectionné pour update
          ref.watch(presentationUpdateStream).when(
                data: (presentation) {
                  /// on ecoute les contents de la presentation
                  final contents =
                      ref.watch(contentsOfPresentationStream(presentation.id!));

                  _title = TextEditingController(text: presentation.title);
                  _subTitle =
                      TextEditingController(text: presentation.subTitle);
                  _email = TextEditingController(text: presentation.email);
                  _address = TextEditingController(text: presentation.address);
                  _codePost =
                      TextEditingController(text: presentation.codePost);
                  _city = TextEditingController(text: presentation.city);
                  _phoneNumber =
                      TextEditingController(text: presentation.phoneNumber);
                  _infoSup = TextEditingController(text: presentation.info);

                  return ContainerBasic(
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
                                PresentationConst
                                    .creationPresentationTitleLabel1,
                                null,
                                context,
                              ),

                              /// input title
                              InputBasic(
                                controller: _title,
                                labelText: PresentationConst
                                    .creationPresentationInputTitle,
                                validator: (value) =>
                                    WooValidator.validatorInputTextBasic(
                                  textError:
                                      WooValidator.errorInputTitlePresentation,
                                  value: value,
                                ),
                              ),

                              /// input sub title
                              InputBasic(
                                controller: _subTitle,
                                labelText: PresentationConst
                                    .creationPresentationInputSubTitle,
                              ),
                            ],
                          ),

                          /// cadre info entreprise
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// label cadre
                              buildLabelPartieFormulairePresentation(
                                PresentationConst
                                    .creationPresentationTitleLabel2,
                                const EdgeInsets.only(top: 70.0),
                                context,
                              ),

                              /// input email
                              InputBasic(
                                controller: _email,
                                labelText: PresentationConst
                                    .creationPresentationInputEmail,
                                validator: (value) =>
                                    WooValidator.validateEmail(
                                  textError: WooValidator.errorInputEmail,
                                  value: value,
                                ),
                              ),

                              /// input addresse
                              InputBasic(
                                controller: _address,
                                labelText: PresentationConst
                                    .creationPresentationInputAddress,
                                validator: (value) =>
                                    WooValidator.validatorInputTextBasic(
                                  textError: WooValidator.errorInputAddresse,
                                  value: value,
                                ),
                              ),

                              /// input code postal
                              InputBasic(
                                controller: _codePost,
                                labelText: PresentationConst
                                    .creationPresentationInputCodePost,
                                validator: (value) =>
                                    WooValidator.validatorInputTextBasic(
                                  textError: WooValidator.errorInputCodePost,
                                  value: value,
                                ),
                              ),

                              /// input ville
                              InputBasic(
                                controller: _city,
                                labelText: PresentationConst
                                    .creationPresentationInputCity,
                                validator: (value) =>
                                    WooValidator.validatorInputTextBasic(
                                  textError: WooValidator.errorInputCity,
                                  value: value,
                                ),
                              ),

                              /// input phoneNumber
                              InputBasic(
                                controller: _phoneNumber,
                                labelText: PresentationConst
                                    .creationPresentationInputPhoneNumber,
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
                                PresentationConst
                                    .creationPresentationTitleLabel3,
                                const EdgeInsets.only(top: 70.0),
                                context,
                              ),

                              /// input info
                              InputBasic(
                                controller: _infoSup,
                                labelText: PresentationConst
                                    .creationPresentationInputInfoSup,
                              )
                            ],
                          ),

                          /// image de presentation
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 70.0),
                                child:
                                    _picker != null || presentation.image != ''
                                        ? _picker != null
                                            ? Image.memory(
                                                _picker!.files.first.bytes!,
                                                height: 100.0,
                                                width: double.infinity,
                                              )
                                            : Image.network(
                                                presentation.image!,
                                                height: 100.0,
                                                width: double.infinity,
                                              )
                                        : Text(PresentationConst
                                            .creationPresentationPickerNull),
                              ),

                              /// btn action image
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 40.0, top: 20.0),
                                child: _picker != null ||
                                        presentation.image != ''
                                    ? presentation.image != ''
                                        ?

                                        /// modification de l'image
                                        Column(
                                            children: [
                                              /// btn modification
                                              Container(
                                                child: TextButton.icon(
                                                  onPressed: () async {
                                                    await _updateImageDirectly(
                                                        presentation);
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary,
                                                  ),
                                                  label: Text(
                                                    "Modifier l'image",
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary),
                                                  ),
                                                ),
                                              ),

                                              /// btn suppression
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20.0),
                                                child: TextButton.icon(
                                                  onPressed: () async {
                                                    await _deleteImageDirectly(
                                                        presentation);
                                                    setState(() {
                                                      _picker = null;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  label: Text(
                                                    PresentationConst
                                                        .creationPresentationBtnSupImage,
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )

                                        /// supprime l'image selectionné
                                        : TextButton.icon(
                                            onPressed: () async {
                                              setState(() {
                                                _picker = null;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            label: Text(
                                              PresentationConst
                                                  .creationPresentationBtnSupImage,
                                              style: const TextStyle()
                                                  .copyWith(color: Colors.red),
                                            ),
                                          )

                                    /// ajouter une image
                                    : TextButton.icon(
                                        onPressed: () async {
                                          await _updateImageDirectly(
                                              presentation);
                                        },
                                        icon: const Icon(Icons.add),
                                        label: const Text("Ajouter une image"),
                                      ),
                              ),
                            ],
                          ),

                          Separate(
                            margin: const EdgeInsets.symmetric(vertical: 20.0),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// label partie contenu
                              buildLabelPartieFormulairePresentation(
                                'Contenu de la présentation',
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                context,
                              ),

                              /// btn ajouter content
                              /// TODO : ajoute un content dans la BDD
                              /// TODO : vérifier que l'ecouteur met à jour la list
                              TextButton.icon(
                                onPressed: () async {
                                  ref
                                      .watch(presentationContentChange)
                                      .addContentOfPresentation(
                                        presentation.id!,
                                        PresentationContentSchema(text: ''),
                                      );
                                },
                                icon: Icon(Icons.add,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                label: Text(
                                  'Ajouter un contenu',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),

                              /// list des contents
                              /// TODO : list des contents sous forme de input
                              /// TODO : sinon on affiche le message pas de content
                              Container(
                                margin: const EdgeInsets.only(top: 30.0),
                                child: Column(children: [
                                  contents.when(
                                    data: (contents) {
                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: contents.length,
                                        itemBuilder: (context, index) {
                                          return PresentationUpdateListContent(
                                            content: contents[index],
                                            idPresentation: presentation.id!,
                                          );
                                        },
                                      );
                                    },
                                    error: (error, stack) =>
                                        const WaitingError(),
                                    loading: () => const WaitingData(),
                                  )
                                ]),
                              ),
                            ],
                          ),

                          Separate(
                            margin:
                                const EdgeInsets.only(bottom: 20.0, top: 50.0),
                          ),

                          /// btn save modification présentation
                          /// btn creer
                          BtnElevatedBasic(
                            margin: const EdgeInsets.only(top: 50.0),
                            onPressed: () async {
                              await _updatePresentation(presentation);
                            },
                            textBtn: 'MODIFIER PRESENTATION',
                          ),

                          /// text info formulaire
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 70.0),
                              child: Text(
                                PresentationConst.creationPresentationInfoform,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stack) => const WaitingError(),
                loading: () => const WaitingData(),
              ),
        ],
      ),
    );
  }
}
