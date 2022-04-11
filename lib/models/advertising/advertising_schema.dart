import 'package:woopear/models/advertising/label/label_schema.dart';

class AdvertisingSchema {
  String? id;
  String? title;
  String? image;
  LabelSchema? label;

  AdvertisingSchema({
    this.id,
    required this.title,
    this.image,
    required this.label,
  });

  factory AdvertisingSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String image = data['image'] ?? '';
    LabelSchema label = data['label'];

    return AdvertisingSchema(
      id: documentId,
      title: title,
      image: image,
      label: label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image ?? '',
      'label': label,
    };
  }
}
