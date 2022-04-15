import 'package:cloud_firestore/cloud_firestore.dart';

class ConditionGeneSchema {
  String? id;
  String title;
  Timestamp? date;
  bool? activate;

  ConditionGeneSchema({
    this.id,
    required this.title,
    this.date,
    this.activate,
  });

  factory ConditionGeneSchema.fromMap(data, documentId) {
    String title = data['title'];
    bool activate = data['activate'];
    Timestamp date = data['date'];

    return ConditionGeneSchema(id: documentId, title: title, date: date, activate: activate);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'activate': activate ?? false,
      'date': date ?? Timestamp.now(),
    };
  }
}
