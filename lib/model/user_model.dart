import 'dart:convert';

List<User> usersFromJson(dynamic str) =>
    List<User>.from((str).map((x) => User.fromJson(x)));

class User {
  final String id;
  final String displayName;
  final String email;
  final String photoUrl;
  final bool status;
  // final DateTime create_at;
  // final DateTime update_at;

  User({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.status,
    // required this.create_at,
    // required this.update_at,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    // final seconds_create = map['create_at']['_seconds'] as int;
    // final nanoseconds_create = map['create_at']['_nanoseconds'] as int;
    //
    // final seconds_update = map['update_at']['_seconds'] as int;
    // final nanoseconds_update = map['update_at']['_nanoseconds'] as int;

    return User(
      id: map['id'] ?? '',
      displayName: map['displayName']?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      status: map['status'] ?? '',
      // create_at: DateTime.fromMicrosecondsSinceEpoch(
      //   seconds_create * 1000000 + nanoseconds_create ~/ 1000,
      //   isUtc: true,
      // ),
      // update_at: DateTime.fromMicrosecondsSinceEpoch(
      //   seconds_update * 1000000 + nanoseconds_update ~/ 1000,
      //   isUtc: true,
      // ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'status': status,
      // 'create_at': create_at,
      // 'update_at': update_at,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);
}
