import 'package:woopear/models/producer/team_woo/team_woo_schema.dart';

class ProducerSchema {
  String? id;
  String? full_name;
  String? job;
  String? description;
  String? image;
  TeamWooSchema? teamWoo;

  ProducerSchema({
    this.id,
    required this.full_name,
    required this.job,
    required this.description,
    this.image,
    required this.teamWoo,
  });

  factory ProducerSchema.fromMap(Map<String, dynamic> data, documentId) {
    String fullName = data['full_name'];
    String job = data['job'];
    String description = data['description'];
    String image = data['image'] ?? '';
    TeamWooSchema teamWoo = data['teamWoo'];

    return ProducerSchema(
      id: documentId,
      full_name: fullName,
      job: job,
      description: description,
      image: image,
      teamWoo: teamWoo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': full_name,
      'job': job,
      'description': description,
      'image': image ?? '',
      'teamWoo': teamWoo,
    };
  }
}
