import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/waiting_data.dart';

class PresentationDetails extends ConsumerStatefulWidget {
  const PresentationDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PresentationDetailsState();
}

class _PresentationDetailsState extends ConsumerState<PresentationDetails> {
  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    /// recuperer list user avec role root
    final allProfil = ref.watch(allProfilProvider);

    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: allProfil != null ? allProfil.length : 0,
      child: Scaffold(
        appBar: AppBarBasic(
          seeMenuProfil: true,
          seeConnexion: user != null ? true : false,
          text: "L'équipe woopear",
          automaticallyImplyLeading: true,
        ),
        body: TabBarView(
          children: allProfil != null
              ? allProfil
                  .map((profil) => SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(30.0),
                          margin: const EdgeInsets.only(bottom: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// image + username
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /// image
                                      Container(
                                        margin: const EdgeInsets.only(top: 5.0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.grey
                                              : Colors.black12,
                                          shape: BoxShape.circle,
                                        ),
                                        child: profil != null &&
                                                profil.avatar != ''
                                            ? CircleAvatar(
                                                radius: 150 / 2,
                                                backgroundImage: NetworkImage(
                                                  profil.avatar!,
                                                ),
                                              )
                                            : const Icon(Icons.person,
                                                size: 150.0),
                                      ),

                                      /// username
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 20.0),
                                        child: profil != null
                                            ? Text(
                                                profil.userName!,
                                                style: const TextStyle(
                                                    fontSize: 46.0),
                                              )
                                            : const WaitingData(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// post
                              buildLabel('Expertise ', _width),
                              profil != null
                                  ? buildInfo(profil.post!, _width)
                                  : const WaitingData(),

                              /// description
                              buildLabel('Présentation ', _width),
                              profil != null
                                  ? buildInfo(profil.description!, _width)
                                  : const WaitingData(),

                              /// infos complementary
                              profil != null
                                  ? buildInfo(profil.infoComplementary!, _width)
                                  : const WaitingData(),

                              /// techno
                              buildLabel('Technos utilisées : ', _width),
                              profil != null
                                  ? buildInfo(profil.techno!, _width)
                                  : const WaitingData(),
                            ],
                          ),
                        ),
                      ))
                  .toList()
              : [
                  Container(),
                ],
        ),
      ),
    );
  }

  /// label des paragraphes
  Widget buildLabel(String label, double largeur) => Container(
        margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
        width: largeur > 700 ? 600 : double.infinity,
        child: Text(
          label,
          style: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );

  /// paragraphe
  Widget buildInfo(String text, double largeur) => Container(
    margin: const EdgeInsets.only(bottom: 20.0),
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        width: largeur > 700 ? 600 : double.infinity,
        child: Text(
          text,
          textAlign: TextAlign.justify,
        ),
      );
}
