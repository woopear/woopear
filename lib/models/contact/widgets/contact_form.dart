import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/widget_shared/input_basic.dart';

class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  final bool _validate = false;
  final TextEditingController _name = TextEditingController(text: '');
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _message = TextEditingController(text: '');

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
            child: Column(
              children: [
                /// input nom + email
                Column(
                  children: [
                    InputBasic(
                          labelText: 'Nom, prénom', controller: _name),
                    
                    InputBasic(labelText: 'E-mail', controller: _email),
                    
                  ],
                ),

                /// textarea message
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: TextField(
                    controller: _message,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Votre message",
                      errorText:
                          _validate ? "Veuillez remplir le champs" : null,
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
