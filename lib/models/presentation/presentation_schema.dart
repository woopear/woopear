class PresentationSchema {
  String? id;
  String title;
  String? subTitle;
  String phoneNumber;
  String email;
  String address;
  String codePost;
  String city;
  String? info;
  String? image;

  PresentationSchema({
    this.id,
    required this.title,
    this.subTitle,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.codePost,
    required this.city,
    this.info,
    this.image,
  });

  factory PresentationSchema.formMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String subTitle = data['subTitle'] ?? '';
    String phoneNumber = data['phoneNumber'];
    String email = data['email'];
    String address = data['address'];
    String codePost = data['codePost'];
    String city = data['city'];
    String info = data['info'] ?? '';
    String image = data['image'] ?? '';

    return PresentationSchema(
      id: documentId,
      title: title,
      subTitle: subTitle,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      codePost: codePost,
      city: city,
      info: info,
      image: image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle ?? '',
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'codePost': codePost,
      'city': city,
      'info': info ?? '',
      'image': image ?? '',
    };
  }
}
