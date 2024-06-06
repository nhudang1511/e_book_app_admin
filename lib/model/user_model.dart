List<User> usersFromJson(dynamic str) =>
    List<User>.from((str).map((x) => User.fromJson(x)));

class User {
  late String id;
  String? displayName;
  late String email;
  String? photoUrl;
  late bool status;

  User(this.id, this.displayName, this.email, this.photoUrl, this.status);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    return data;
  }
}
