import 'package:woopear/models/companie/companie_schema.dart';
import 'package:woopear/models/role/role_schema.dart';

class ProfilSchema {
  String? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? address;
  String? city;
  String? codePost;
  String? phoneNumber;
  String? avatar;
  String uid;
  CompanieSchema? companie;
  RoleSchema role;

  ProfilSchema({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.codePost,
    this.phoneNumber,
    this.avatar,
    required this.uid,
    this.companie,
    required this.role,
  });

  factory ProfilSchema.fromMap(Map<String, dynamic> data, documentId) {
    String userName = data['userName'] ?? '';
    String firstName = data['firstName'] ?? '';
    String lastName = data['lastName'] ?? '';
    String address = data['address'] ?? '';
    String city = data['city'] ?? '';
    String codePost = data['codePost'] ?? '';
    String phoneNumber = data['phoneNumber'] ?? '';
    String avatar = data['avatar'] ?? '';
    String uid = data['uid'];
    CompanieSchema companie = data['companie'] ?? '';
    RoleSchema role = data['role'];

    return ProfilSchema(
      id: documentId,
      userName: userName,
      firstName: firstName,
      lastName: lastName,
      address: address,
      city: city,
      codePost: codePost,
      phoneNumber: phoneNumber,
      avatar: avatar,
      companie: companie,
      role: role,
      uid: uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'city': city,
      'codePost': codePost,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'companie': companie,
      'role': role,
      'uid': uid,
    };
  }
}
