import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/widgets/profil_list/profil_list.dart';

class John extends ConsumerStatefulWidget {
  const John({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JohnState();
}

class _JohnState extends ConsumerState<John> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: const [
                ProfilList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
