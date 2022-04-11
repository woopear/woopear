import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/companie/companie_schema.dart';
import 'package:woopear/models/profil/widgets/profil_info_companie/label.dart';
import 'package:woopear/widget_shared/container_basic.dart';

class ProfilInfoCompanie extends ConsumerStatefulWidget {
  CompanieSchema companie;
  bool seeUpdate;

  ProfilInfoCompanie({
    Key? key,
    required this.companie,
    required this.seeUpdate,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilInfoCompanieState();
}

class _ProfilInfoCompanieState extends ConsumerState<ProfilInfoCompanie> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// label
          buildLabelInfoCompanie(),

          /// info entreprise
          ContainerBasic(
            margin: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title avec la dénomination
                widget.companie.denomination != ''
                    ? Text(
                        widget.companie.denomination,
                        style: const TextStyle().copyWith(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        'Aucune entreprise',
                        style: const TextStyle().copyWith(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                /// codeNaf + siret
                widget.companie.siret != ''
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Numero de siret : ' + widget.companie.siret,
                            style: const TextStyle()
                                .copyWith(fontSize: 16.0, color: Colors.grey),
                          ),
                          Text(
                            'Code NAF : ' + widget.companie.codeNaf,
                            style: const TextStyle()
                                .copyWith(fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      )
                    : Container(),

                /// adresse
                widget.companie.address != ''
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// address
                          Text(
                            widget.companie.address!,
                            style: const TextStyle()
                                .copyWith(fontSize: 16.0, color: Colors.grey),
                          ),

                          /// codepost + ville
                          Text(
                            widget.companie.codePost! +
                                ' ' +
                                widget.companie.city!,
                            style: const TextStyle()
                                .copyWith(fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
