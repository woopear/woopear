import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/profil/profil_const.dart';
import 'package:woopear/models/profil/profil_schema.dart';
import 'package:woopear/models/profil/profil_state.dart';
import 'package:woopear/models/profil/role/role_schema.dart';
import 'package:woopear/models/user/user_state.dart';
import 'package:woopear/models/user/widgets/signup/signup_dropdown_role.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class ProfilCreateForm extends ConsumerStatefulWidget {
  const ProfilCreateForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilCreateFormState();
}

class _ProfilCreateFormState extends ConsumerState<ProfilCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController(text: '');
  RoleSchema? _role;

  /// reset des controllers des inputs
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  /// selection du role
  void setRole(RoleSchema? role) {
    setState(() {
      _role = role;
    });
  }

  void resetInput() {
    _formKey.currentState!.reset();
    _email.clear();
    setState(() {
      _role = null;
    });
  }

  /// creation d'un profil + envoie mail à l'utilisateur pour creer son compte
  Future<void> _creationProfil(BuildContext context) async {
    /// si form OK
    if (_formKey.currentState!.validate()) {
      if (_role == null) {
        /// notification error
        NotificationBasic(
          text: ProfilConst.errorRole,
          error: true,
        ).notification(context);
        throw Exception(ProfilConst.errorRole);
      }

      /// creation profil
      ProfilSchema newProfil = ProfilSchema(
          email: _email.text.trim(),
          firstName: '',
          lastName: '',
          userName: '',
          address: '',
          city: '',
          codePost: '',
          uid: '',
          role: RoleSchema(
              libelle: _role!.libelle, description: _role!.description));

      /// creation profil
      await ref.watch(profilChange).addProfil(newProfil);

      /// envoie mail
      await ref.watch(userChange).sendMailForFinishAccount(_email.text.trim());

      resetInput();

      /// notification succes
      NotificationBasic(
        text: ProfilConst.messageSucces,
        error: false,
      ).notification(context);
    } else {
      /// notification error
      NotificationBasic(
        text: ProfilConst.messageError,
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// input role
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: SignupDropdownRole(
                  dropdownValue: _role,
                  onChanged: (value) => setRole(value),
                ),
              ),
            ),

            /// input email
            InputBasic(
              labelText: ProfilConst.placeholder,
              controller: _email,
              validator: (value) => WooValidator.validateEmail(
                textError: WooValidator.errorInputEmail,
                value: value,
              ),
            ),

            /// btn creer
            Align(
              alignment: Alignment.centerRight,
              child: BtnElevatedBasic(
                margin: const EdgeInsets.only(top: 50.0),
                onPressed: () async {
                  await _creationProfil(context);
                },
                textBtn: ProfilConst.btnCreationProfil,
              ),
            ),

            /// text info formulaire
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: Text(
                  ProfilConst.infoFormulaire,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
