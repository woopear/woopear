import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/utils/config/routes.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
  final user = ref.watch(profilCurrentProvider);
    return Container(
      child: Column(
        children: [
          Text(user?.firstName ?? ''),
          
          ElevatedButton(
            onPressed: () async {
              Navigator.popAndPushNamed(context, Routes().createProfil);
            },
            child: const Text('creation profil'),
          ),
        ],
      ),
    );
  }
}
