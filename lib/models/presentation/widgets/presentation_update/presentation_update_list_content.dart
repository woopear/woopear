import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/presentation/presentation_content/presentation_content_schema.dart';
import 'package:woopear/models/presentation/presentation_content/presentation_content_state.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class PresentationUpdateListContent extends ConsumerStatefulWidget {
  PresentationContentSchema content;
  String idPresentation;

  PresentationUpdateListContent({
    Key? key,
    required this.content,
    required this.idPresentation,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationUpdateListContentState();
}

class _PresentationUpdateListContentState
    extends ConsumerState<PresentationUpdateListContent> {
  TextEditingController _text = TextEditingController(text: '');
  TextEditingController _subTitle = TextEditingController(text: '');
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _text = TextEditingController(text: widget.content.text);
    _subTitle = TextEditingController(text: widget.content.subTitle);
  }

  @override
  void dispose() {
    _text.dispose();
    _subTitle.dispose();
    super.dispose();
  }

  /// update content de la presentation
  Future<void> updateContent() async {
    PresentationContentSchema newContent = PresentationContentSchema(
      text: _text.text.trim(),
      subTitle: _subTitle.text.trim(),
    );

    await ref.watch(presentationContentChange).updateContentOfPresentation(
        widget.idPresentation, widget.content.id!, newContent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70.0),
      child: Column(
        children: [
          /// btn supprimer content
          Row(
            children: [
              Expanded(child: Text('Paragraphe : ${widget.content.id}')),
              Tooltip(
                message: 'Supprimer le paragraphe',
                child: IconButton(
                  onPressed: () async {
                    await ref
                        .watch(presentationContentChange)
                        .deleteContentOfPresentation(
                            widget.idPresentation, widget.content.id!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

          /// input subtitle
          InputBasic(labelText: 'Sous titre', controller: _subTitle),

          /// input text
          Container(
            margin: const EdgeInsets.only(top: 30.0),
            child: TextField(
            controller: _text,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Ecrire mon text",
              errorText: _validate ? "Veuillez remplir le champs" : null,
            ),
          ),
          ),
          

          /// btn enregistrer
          BtnElevatedBasic(
            onPressed: () async {
              setState(() {
                _text.text.isEmpty ? _validate = true : _validate = false;
              });

              await updateContent();
            },
            textBtn: 'ENREGISTRER',
            margin: const EdgeInsets.only(top: 50.0),
          ),
        ],
      ),
    );
  }
}
