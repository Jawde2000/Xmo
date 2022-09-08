import 'dart:convert';

class Verification {
  final String id;
  final String email;
  final String D6_Number;
  final String token;

  Verification({required this.id, required this.email, required this.D6_Number, required this.token});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'D6_Number': D6_Number,
      'token': token,
    };
  }

  factory Verification.fromMap(Map<String, dynamic> map) {
    return Verification(
      id: map['_id'] ?? '',
      D6_Number: map['verificationNumber'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Verification.fromJson(String source) =>
      Verification.fromMap(json.decode(source) as Map<String, dynamic>);
}