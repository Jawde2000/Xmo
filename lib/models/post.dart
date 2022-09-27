import 'dart:convert';

class Post {
  final String id;
  final String message;
  final String userId;
  Post({
    required this.id,
    required this.message,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'userId': userId
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'] ?? '',
      message: map['message'] ?? '',
      userId: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
