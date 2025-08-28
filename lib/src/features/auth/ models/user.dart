import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String email;

  UserModel({required this.id, required this.email});

  factory UserModel.fromFirebase(User userCredential) {
    return UserModel(id: userCredential.uid, email: userCredential.email ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] ?? '', email: json['email'] ?? '');
  }
}
