import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/widgets/profil_info.dart/label.dart';
import 'package:woopear/widget_shared/container_basic.dart';

class ProfilInfo extends ConsumerStatefulWidget {
  ProfilSchema profil;
  bool seeUpdate;
  void Function()? onPressed;

  ProfilInfo({Key? key, required this.profil, required this.seeUpdate, required this.onPressed})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilInfoState();
}

class _ProfilInfoState extends ConsumerState<ProfilInfo> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// affichage info personnelle
          Stack(
            children: [
              /// label
              buildLabelProfilInfo(),

              ContainerBasic(
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// user name
                    Container(
                      child: Text(
                        widget.profil.userName!,
                        style: const TextStyle().copyWith(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// email
                    Container(
                      child: Text(
                        widget.profil.email,
                        style: const TextStyle()
                            .copyWith(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),

                    /// addresse
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// address
                          Text(
                            widget.profil.address,
                            style: const TextStyle()
                                .copyWith(fontSize: 16.0, color: Colors.grey),
                          ),

                          /// codepost + ville
                          Text(
                            widget.profil.codePost + ' ' + widget.profil.city,
                            style: const TextStyle()
                                .copyWith(fontSize: 14.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    /// telephone
                    Container(
                        child: widget.profil.phoneNumber! != ''
                            ? Text(
                                widget.profil.phoneNumber!,
                                style: const TextStyle().copyWith(
                                    fontSize: 16.0, color: Colors.grey),
                              )
                            : Container()),
                  ],
                ),
              ),

              /// btn update
              Positioned(
                top: 20,
                right: 20,
                child: Tooltip(
                  message: 'Modifier mon profil',
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        widget.onPressed!();
                      },
                      icon: Icon(
                        Icons.mode_edit_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// update info personnelle
        ],
      ),
    );
  }
}
