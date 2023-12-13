List<Author> authorsFromJson(dynamic str) =>
    List<Author>.from((str).map((x) => Author.fromJson(x)));

class Author {
  late String? id;
  late String? fullName;
  late bool? status;

  Author(this.id, this.fullName, this.status);

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['status'] = status;
    return data;
  }
}
