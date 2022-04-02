import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/role/role_schema.dart';

class SignupDropdownRole extends ConsumerStatefulWidget {
  const SignupDropdownRole({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignupDropdownRoleState();
}

class _SignupDropdownRoleState extends ConsumerState<SignupDropdownRole> {
  RoleSchema dropdownValue = rolesBase[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      decoration: BoxDecoration(
        color: const Color(0xFF202225),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<RoleSchema>(
          /// TODO design drop + continuer recuperer valeur selectionné
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: (RoleSchema? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items:
              rolesBase.map<DropdownMenuItem<RoleSchema>>((RoleSchema value) {
            return DropdownMenuItem<RoleSchema>(
              value: value,
              child: Text(value.libelle),
            );
          }).toList(),
        ),
      ),
    );
  }
}
