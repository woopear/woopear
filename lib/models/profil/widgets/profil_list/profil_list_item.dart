import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/pages/private/profil/profil_select.dart';

class ProfilListItem extends ConsumerStatefulWidget {
  ProfilSchema item;
  ProfilListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilListItemState();
}

class _ProfilListItemState extends ConsumerState<ProfilListItem> {
  Future<void> deleteProfilAndUser(String idProfil) async {
    await ref.watch(profilChange).deleteProfil(idProfil);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          /// nom prenom
          Expanded(
            child: Text(
              widget.item.userName != ''
                  ? widget.item.userName!
                  : 'Pas encore de nom',
              style: GoogleFonts.nunito(fontSize: 14.0),
            ),
          ),

          /// email
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.item.email != '' ? widget.item.email : "Pas d'email",
              style: GoogleFonts.nunito(fontSize: 14.0),
            ),
          ),

          /// action
          /// voir
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilSelect(profil: widget.item),
                ),
              );
            },
            icon: const Icon(Icons.visibility_rounded),
          ),

          ///suppression
          IconButton(
            onPressed: () async {
              await deleteProfilAndUser(widget.item.id!);
            },
            icon: const Icon(Icons.delete_rounded, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
