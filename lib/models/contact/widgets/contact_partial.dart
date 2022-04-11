import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woopear/models/contact/widgets/contact_form.dart';
import 'package:woopear/widget_shared/title_page_auth.dart';

class ContactPartial extends ConsumerStatefulWidget {
  const ContactPartial({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactPartialState();
}

class _ContactPartialState extends ConsumerState<ContactPartial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 70.0, left: 30.0, right: 30.0, bottom: 80.0),
      child: Column(
        children: [
          /// title + sub title
          Container(
            child: Column(
              children: [
                const TitlePageAuth(
                  text: 'Contactez-nous',
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Nous vous répondrons dans les plus brefs délai.',
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// fomulaire de contact
          const ContactForm(),
        ],
      ),
    );
  }
}
