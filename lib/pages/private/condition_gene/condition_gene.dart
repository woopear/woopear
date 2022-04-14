import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:woopear/models/condition_gene/widgets/condition_gene_create/condition_gene_create.dart';
import 'package:woopear/models/condition_gene/widgets/condition_gene_list/condition_gene_list.dart';
import 'package:woopear/widget_shared/app_bar_basic.dart';
import 'package:woopear/widget_shared/drawer_basic.dart';
import 'package:woopear/widget_shared/sub_title_auth.dart';

class ConditionGene extends ConsumerStatefulWidget {
  const ConditionGene({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConditionGeneState();
}

class _ConditionGeneState extends ConsumerState<ConditionGene> {
  bool seeListConditionGene = true;
  bool seeCreateConditionGene = false;

  void seeCreate() {
    setState(() {
      seeListConditionGene = false;
      seeCreateConditionGene = true;
    });
  }

  void seeList() {
    setState(() {
      seeListConditionGene = true;
      seeCreateConditionGene = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere le user
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Scaffold(
        drawer: user != null ? const DrawerBasic() : null,
        appBar: AppBarBasic(
          seeConnexion: user != null ? true : false,
          text: 'Gestion Conditions générales',
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ///list
                seeListConditionGene
                    ? Container(
                        child: Column(
                          children: [
                            ///title list
                            buildTitleConditionGene(
                                title: 'Liste des conditions générales'),

                            const ConditionGeneList(),
                          ],
                        ),
                      )
                    : Container(),

                /// create condition
                seeCreateConditionGene
                    ? Container(
                        child: Column(
                          children: [
                            ///title create
                            buildTitleConditionGene(
                                title: "Creation d'une condition générale"),

                            const ConditionGeneCreate(),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),

        /// menu inferieur fixe
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spacing: 20.0,
          spaceBetweenChildren: 20.0,
          foregroundColor: Colors.white,
          children: [
            /// icon menu ajouter un profil
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: 'Créer une condition générale',
                onTap: () {
                  seeCreate();
                }),

            /// icon menu liste des profils
            SpeedDialChild(
                child: const Icon(Icons.list),
                label: 'Liste des conditions générales',
                onTap: () {
                  seeList();
                }),
          ],
        ),
      ),
    );
  }

  /// title des page condition gene private
  Widget buildTitleConditionGene({
    String? subTitle,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0, bottom: 70.0),
      child: Column(
        children: [
          /// title
          Container(
            child: SubTitlePageAuth(text: title),
          ),

          /// sub title
          subTitle != null
              ? Text(
                  subTitle,
                  style: const TextStyle().copyWith(fontSize: 16.0),
                )
              : Container(),
        ],
      ),
    );
  }
}
