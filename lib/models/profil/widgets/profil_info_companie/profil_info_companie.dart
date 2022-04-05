import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';

class ProfilInfoCompanie extends ConsumerWidget {
  ProfilSchema profil;
  ProfilInfoCompanie({Key? key, required this.profil}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          /// title avec la dénomination
          profil.companie!.denomination != '' && profil.companie != null
              ? Text(
                  profil.companie!.denomination,
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
          profil.companie!.siret != '' ?
          Container(
            margin: const EdgeInsets.only(bottom: 30.0, top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Numero de siret : ' + profil.companie!.siret, style: const TextStyle()
                      .copyWith(fontSize: 14.0, color: Colors.grey),),
                Text('Code NAF : ' + profil.companie!.codeNaf, style: const TextStyle()
                      .copyWith(fontSize: 14.0, color: Colors.grey),),
              ],
            ),
          ) : Container(),
          
          /// adresse
          profil.companie != null && profil.companie!.address != '' ?
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// address
                Text(profil.companie!.address!),

                /// codepost + ville
                Text(profil.codePost + ' ' + profil.city),
              ],
            ),
          ) : Container(), 
        ],
      ),
    );
  }
}
