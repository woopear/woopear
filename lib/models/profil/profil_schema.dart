import 'package:woopear/models/profil/companie/companie_schema.dart';
import 'package:woopear/models/profil/role/role_schema.dart';

class ProfilSchema {
  String? id;
  String? userName;
  String email;
  String firstName;
  String lastName;
  String address;
  String city;
  String codePost;
  String? phoneNumber;
  String? avatar;
  String uid;
  CompanieSchema? companie;
  RoleSchema role;

  ProfilSchema({
    this.id,
    this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.codePost,
    this.phoneNumber,
    this.avatar,
    required this.uid,
    this.companie,
    required this.role,
  });

  factory ProfilSchema.fromMap(Map<String, dynamic> data, documentId) {
    String userName = data['userName'] ?? '';
    String email = data['email'];
    String firstName = data['firstName'];
    String lastName = data['lastName'];
    String address = data['address'];
    String city = data['city'];
    String codePost = data['codePost'];
    String phoneNumber = data['phoneNumber'] ?? '';
    String avatar = data['avatar'] ?? '';
    String uid = data['uid'];
    CompanieSchema companie = data['companie'] ?? '';
    RoleSchema role = data['role'];

    return ProfilSchema(
      id: documentId,
      userName: userName,
      email: email,
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
      'userName': userName ?? '',
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
      'address': address,
      'city': city,
      'codePost': codePost,
      'phoneNumber': phoneNumber ?? '',
      'avatar': avatar ?? '',
      /// TODO: companie en test si à la récuperation cela bug nous changerons
      'companie': companie?.toMap(),
      'role': role.toMap(),
      'uid': uid,
    };
  }
}
