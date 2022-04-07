import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woopear/models/profil/role/role_schema.dart';
import 'package:woopear/models/user/user_const.dart';

class SignupDropdownRole extends ConsumerStatefulWidget {
  RoleSchema? dropdownValue;
  void Function(RoleSchema?)? onChanged;

  SignupDropdownRole(
      {Key? key, required this.dropdownValue, required this.onChanged})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignupDropdownRoleState();
}

class _SignupDropdownRoleState extends ConsumerState<SignupDropdownRole> {
  void Function(RoleSchema?)? _onChanged;

  @override
  void initState() {
    super.initState();
    _onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /// couleur et forme
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonHideUnderline(
        /// list selectionnable
        child: DropdownButton<RoleSchema>(
          value: widget.dropdownValue == null ? widget.dropdownValue : rolesBase.where((el) => el.libelle == widget.dropdownValue!.libelle).first,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          onChanged: _onChanged,
          items:
              rolesBase.map<DropdownMenuItem<RoleSchema>>((RoleSchema value) {
            return DropdownMenuItem<RoleSchema>(
              value: value,
              child: Text(
                value.libelle,
                style: GoogleFonts.nunito(fontSize: 20.0),
              ),
            );
          }).toList(),

          /// placeholder
          hint: Text(UserConst.createPlaceholderDropdownRole,
              style: GoogleFonts.nunito(fontSize: 20.0)),
        ),
      ),
    );
  }
}
