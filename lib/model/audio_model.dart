List<Audio> audiosFromJson(dynamic str) =>
    List<Audio>.from((str).map((x) => Audio.fromJson(x)));

class Audio{
  late String id;
  late String bookId;
  late Map<String, dynamic> chapterList;

  Audio(this.id, this.bookId, this.chapterList);

  Audio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['bookId'];
    chapterList = Map<String, dynamic>.from(json['chapterList']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['bookId'] = bookId;
    data['chapterList'] = chapterList;
    return data;
  }
}