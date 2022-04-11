import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/contact/contact_state.dart';
import 'package:woopear/utils/constants/woo_validator.dart';
import 'package:woopear/widget_shared/btn_elevated_basic.dart';
import 'package:woopear/widget_shared/input_basic.dart';
import 'package:woopear/widget_shared/notification_basic.dart';

class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  bool _validate = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _message = TextEditingController(text: '');

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    _formKey.currentState!.reset();
    super.dispose();
  }

  void resetInput() {
    setState(() {
      _formKey.currentState!.reset();
      _name.clear();
      _email.clear();
      _message.clear();
      _validate = false;
    });
  }

  /// envoie email de contact
  Future<void> _sendMailForWoopear(BuildContext context) async {
   setState(() => _isLoading = true); 

    if (_formKey.currentState!.validate()) {
      const subject = "Demande de contact accueil woopear";
      await ref
          .watch(contactChange)
          .sendEmailContactClient(subject, _name, _email, _message);

      resetInput();

      /// notification succes
      NotificationBasic(
        text: 'Email envoyé',
        error: false,
      ).notification(context);
      setState(() => _isLoading = false);
    } else {
      /// notification error
      NotificationBasic(
        text: 'Une erreur est survenu',
        error: true,
      ).notification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// on recupere la largeur de l'ecran
    double _width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      width: _width > 700 ? 600 : double.infinity,
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                /// input nom + email
                Column(
                  children: [
                    InputBasic(
                      labelText: 'Nom *',
                      controller: _name,
                      validator: (value) =>
                          WooValidator.validatorInputTextBasic(
                              textError: WooValidator.errorInputFirstName,
                              value: value),
                    ),
                    InputBasic(
                      labelText: 'E-mail *',
                      controller: _email,
                      validator: (value) =>
                          WooValidator.validatorInputTextBasic(
                              textError: WooValidator.errorInputEmail,
                              value: value),
                    ),
                  ],
                ),

                /// textarea message
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: TextField(
                    controller: _message,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Votre message *",
                      errorText:
                          _validate ? "Veuillez remplir le champ" : null,
                    ),
                  ),
                ),

                /// btn envoie mail
                BtnElevatedBasic(
                  isLoading: _isLoading,
                  margin: const EdgeInsets.only(top: 60.0),
                  onPressed: () async {
                    setState(() {
                      _message.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });

                    await _sendMailForWoopear(context);
                  },
                  textBtn: 'ENVOYEZ VOTRE MESSAGE',
                ),

                /// text info formulaire
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    child: Text(
                      '* Champ obligatoire',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
