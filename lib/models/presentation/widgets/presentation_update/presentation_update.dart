import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_const.dart';
import 'package:woopear/models/presentation/presentation_state.dart';
import 'package:woopear/models/presentation/widgets/presentation_create/label.dart';
import 'package:woopear/models/presentation/widgets/presentation_update/title.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/container_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
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
                                        TextButton.icon(
                                            onPressed: () async {
                                              /// TODO : action modifier image
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                            ),
                                            label: const Text(
                                              "Modifier l'image",
                                            ),
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
                                          /// TODO: ajouter une image si il y en a pas
                                        },
                                        icon: const Icon(Icons.add),
                                        label: const Text("Ajouter une image"),
                                      ),
                              ),
                            ],
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
