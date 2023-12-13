List<User> usersFromJson(dynamic str) =>
    List<User>.from((str).map((x) => User.fromJson(x)));
class User {
  late String id;
  late String fullName;
  late String email;
  late String imageUrl;
  late String passWord;
  late String phoneNumber;
  late String provider;
  late bool status;

  User(this.id, this.fullName, this.email, this.imageUrl, this.passWord,
      this.phoneNumber, this.provider, this.status);

  User.fromJson(Map<String, dynamic> json) {
    id = json ['id'];
    fullName = json ['fullName'];
    email = json ['email'];
    imageUrl = json ['imageUrl'];
    passWord = json ['passWord'];
    phoneNumber = json ['phoneNumber'];
    provider = json ['provider'];
    status = json ['status'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] =id;
    data['fullName'] =fullName;
    data['email'] =email;
    data['imageUrl'] =imageUrl;
    data['passWord'] =passWord;
    data['phoneNumber'] =phoneNumber;
    data['provider'] =provider;
    data['status'] =status;
    return data;
  }
}