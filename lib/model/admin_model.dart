List<Admin> adminsFromJson(dynamic str) => List<Admin>.from((str).map((x) => Admin.fromJson(x)));
class Admin{
  late String id;
  late String fullName;
  late String email;
  late String passWord;
  late bool status;

  Admin(this.id, this.fullName, this.email, this.passWord, this.status);

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    passWord = json['passWord'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['passWord'] = passWord;
    data['status'] = status;
    return data;
  }
}