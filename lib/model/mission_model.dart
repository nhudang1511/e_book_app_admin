List<Mission> missionsFromJson(dynamic str) =>
    List<Mission>.from((str).map((x) => Mission.fromJson(x)));

class Mission {
  late String id;
  late int coins;
  late String detail;
  late String name;
  late int times;
  late String type;

  Mission(
    this.id,
    this.coins,
    this.detail,
    this.name,
    this.times,
    this.type,
  );

  Mission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coins = json['coins'];
    detail = json['detail'];
    name = json['name'];
    times = json['times'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['coins'] = coins;
    data['detail'] = detail;
    data['name'] = name;
    data['times'] = times;
    data['type'] = type;
    return data;
  }
}
