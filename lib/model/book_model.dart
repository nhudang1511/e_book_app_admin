List<Book> booksFromJson(dynamic str) =>
    List<Book>.from((str).map((x) => Book.fromJson(x)));
class Book {
  late String id;
  late String authodId;
  late List<String> categoryId;
  late String description;
  late dynamic imageUrl;
  late String language;
  late int price;
  late DateTime publishDate;
  late bool status;
  late String title;
  late List<dynamic> bookPreview;
  late int chapters;
  late String country;

  Book(
    this.id,
    this.authodId,
    this.categoryId,
    this.description,
    this.imageUrl,
    this.language,
    this.price,
    this.publishDate,
    this.status,
    this.title,
    this.bookPreview,
    this.chapters,
    this.country,
  );

  Book.fromJson(Map<String, dynamic> json) {
    final seconds = json['publishDate']['_seconds'] as int;
    final nanoseconds = json['publishDate']['_nanoseconds'] as int;

    id = json['id'];
    authodId = json['authodId'];
    if (json['categoryId'] != null) {
      categoryId = List<String>.from(json['categoryId'].map((x) => x.toString()));
    }
    description = json['description'];
    imageUrl = json['imageUrl'];
    language = json['language'];
    price = json['price'];
    publishDate = DateTime.fromMicrosecondsSinceEpoch(
      seconds * 1000000 + nanoseconds ~/ 1000,
      isUtc: true,
    );
    status = json['status'];
    title = json['title'];
    if (json['bookPreview'] != null) {
      bookPreview = List<String>.from(json['bookPreview'].map((x) => x.toString()));
    }
    // bookPreview = List<String>.from(json['bookPreview']);
    chapters = json['chapters'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id']= id ;
    data['authodId']= authodId ;
    data['categoryId']= categoryId ;
    data['description']= description ;
    data['imageUrl']= imageUrl ;
    data['language']= language ;
    data['price']= price ;
    data['publishDate']= publishDate ;
    data['status']= status ;
    data['title']= title ;
    data['bookPreview']= bookPreview ;
    data['chapters']= chapters ;
    data['country']= country ;
    return data;
  }
}
