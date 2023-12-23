List<Chapters> chaptersFromJson(dynamic str) =>
    List<Chapters>.from((str).map((x) => Chapters.fromJson(x)));

class Chapters{
  late String id;
  late String bookId;
  late Map<String, dynamic> chapterList;

  Chapters(this.id, this.bookId, this.chapterList);

  Chapters.fromJson(Map<String, dynamic> json) {
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