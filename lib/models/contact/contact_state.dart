import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ContactState extends ChangeNotifier {
  final _url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final String _serviceId = 'service_a30i758';
  final String _templateId = 'template_d9ux35h';
  final String _userId = 'vTJ7Vnhs75H5wSA5u';

  /// envoie email de contact
  Future<void> sendEmailContactClient(
      String subject,
      TextEditingController userName,
      TextEditingController userEmail,
      TextEditingController userMessage) async {
    await http.post(
      _url,
      headers: {'origin': 'http://localhost','Content-Type': 'application/json'},
      body: json.encode({
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _userId,
        'template_params': {
          'user_subject': subject,
          'user_name': userName.text.trim(),
          'user_email': userEmail.text.trim(),
          'user_message': userMessage.text.trim(),
        }
      }),
    );
  }
}

/// state class ContactState
final contactChange =
    ChangeNotifierProvider<ContactState>((ref) => ContactState());
