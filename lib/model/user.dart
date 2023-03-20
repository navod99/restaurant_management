import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUser {
  String id;
  String email;
  String name;

  RegisterUser({required this.id, required this.email, required this.name});

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name};
  }

  factory RegisterUser.fromMap(DocumentSnapshot data) {
    return RegisterUser(
      id: data.id,
      email: data['email'],
      name: data['name'],
    );
  }
}
