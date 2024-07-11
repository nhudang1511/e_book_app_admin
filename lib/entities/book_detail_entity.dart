import 'package:e_book_admin/model/models.dart';

class BookDetailEntity {
  final String id;
  final Author author;
  final List<Category> categories;
  final String description;
  final dynamic imageUrl;
  final String language;
  final int price;
  // final DateTime publishDate;
  final bool status;
  final String title;
  final dynamic bookPreview;
  final int chapters;
  final String country;
  final Chapters? listChapters;
  final Audio? listAudios;

  BookDetailEntity({
    required this.id,
    required this.author,
    required this.categories,
    required this.description,
    required this.imageUrl,
    required this.language,
    required this.price,
    // required this.publishDate,
    required this.status,
    required this.title,
    required this.bookPreview,
    required this.chapters,
    required this.country,
    required this.listChapters,
    required this.listAudios,
  });
}
