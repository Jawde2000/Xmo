// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String pass;
  final String email;
  final String address;
  final String userType;
  final String token;

  User(
      {required this.id,
      required this.name,
      required this.pass,
      required this.email,
      required this.address,
      required this.userType,
      required this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pass': pass,
      'email': email,
      'address': address,
      'userType': userType,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      pass: map['pass'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      userType: map['userType'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
