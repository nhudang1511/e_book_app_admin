import 'dart:convert';

class Admin {
  final String id;
  final String fullName;
  final String email;
  final String passWord;
  final bool status;

  Admin({
    required this.id,
    required this.fullName,
    required this.email,
    required this.passWord,
    required this.status,
  });

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      passWord: map['passWord'] ?? '',
      status: map['status'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'passWord': passWord,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(Map<String, dynamic> source) => Admin.fromMap(source);
}
