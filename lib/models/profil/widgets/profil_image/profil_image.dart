import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/upload/upload_state.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class ProfilImage extends ConsumerStatefulWidget {
  String urlAvatar;
  ProfilSchema profil;

  ProfilImage({Key? key, required this.urlAvatar, required this.profil})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilImageState();
}

class _ProfilImageState extends ConsumerState<ProfilImage> {
  dynamic _file;
  String? _extention;
  String? _url;

  /// upload l'image du profil
  Future<void> uploadAvatar() async {
    /// si web sinon le reste
    if (kIsWeb) {
      /// creation conteneur pour fichier
      final picker = await FilePicker.platform.pickFiles();
      if (picker == null) {
        /// notification error
        NotificationBasic(
          text: "Modification de l'image annulée",
          error: true,
        ).notification(context);
        throw Exception("Modification de l'image annulée");
      }

      /// on recupere le path
      setState(() {
        _file = picker.files.first.bytes;
        _extention = picker.files.first.extension;
      });

      _url = await ref
          .watch(uploadFileChange)
          .uploadAvatar(_file, widget.profil.uid, extension: _extention!);
    } else {
      /// creation conteneur pour fichier
      final picker = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (picker == null) return;

      /// on recupere le fichier
      setState(() {
        _file = File(picker.files.single.path!);
      });

      _url = await ref
          .watch(uploadFileChange)
          .uploadAvatar(_file, widget.profil.uid);
    }

    /// on affecte l'url à avatar du user
    widget.profil.avatar = _url;

    /// modifier user pour ajouter url à avatar
    await ref
        .watch(profilChange)
        .updateProfil(widget.profil, widget.profil.id!);

    /// reset et ferme le volet update image
    _file = null;
    _extention = null;
    _url = null;

    /// notification succes
    NotificationBasic(
      text: "Image modifié",
      error: false,
    ).notification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              /// image
              /// si image on affiche image sinon on affiche logo person
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey
                      : Colors.black12,
                  shape: BoxShape.circle,
                ),
                child: widget.urlAvatar != ''
                    ? CircleAvatar(
                        radius: 200 / 2,
                        backgroundImage: NetworkImage(
                          widget.urlAvatar,
                        ),
                      )
                    : const Icon(Icons.person, size: 200.0),
              ),

              /// btn update
              Positioned(
                bottom: 0,
                right: 5,
                child: Tooltip(
                  message: 'Modifier mon image de profil',
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await uploadAvatar();
                      },
                      icon: Icon(
                        Icons.photo_library,
                        size: 30,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
