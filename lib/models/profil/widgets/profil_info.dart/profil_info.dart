import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_schema.dart';

class ProfilInfo extends ConsumerWidget {
  ProfilSchema profil;
  ProfilInfo({Key? key, required this.profil}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          /// les infos du profil
          /// user name (firstname + lastname)
          Container(
            margin: const EdgeInsets.only(top: 20.0, bottom: 40.0),
            child: Column(
              children: [
                /// username
                Text(
                  profil.userName!,
                  style: const TextStyle().copyWith(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// email
                Text(
                  profil.email,
                  style: const TextStyle()
                      .copyWith(fontSize: 14.0, color: Colors.grey),
                ),

                /// telephone
                Text(
                  profil.phoneNumber!,
                  style: const TextStyle()
                      .copyWith(fontSize: 14.0, color: Colors.grey),
                ),
              ],
            ),
          ),

          /// addresse
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// address
                Text(profil.address),

                /// codepost + ville
                Text(profil.codePost + ' ' + profil.city),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
