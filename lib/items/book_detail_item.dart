import 'package:e_book_admin/entities/entities.dart';
import 'package:e_book_admin/model/models.dart';

class BookDetailItem extends BookDetailEntity {
  BookDetailItem({
    required super.id,
    required super.author,
    required super.categories,
    required super.description,
    required super.imageUrl,
    required super.language,
    required super.price,
    // required super.publishDate,
    required super.status,
    required super.title,
    required super.bookPreview,
    required super.chapters,
    required super.country,
    required super.listChapters,
    required super.listAudios,
  });

  factory BookDetailItem.fromJson(Map<String, dynamic> json) {
    return BookDetailItem(
      id: json['id'] ?? '',
      author: Author.fromJson(json['author']),
      categories: categoriesFromJson(json['category']),
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      language: json['language'] ?? '',
      price: json['price'] ?? '',
      // publishDate: json['publishDate'] ?? '',
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      bookPreview: json['bookPreview'] ?? '',
      chapters: json['chapters'] ?? '',
      country: json['country'] ?? '',
      listChapters: json['listChapters'] != null
          ? Chapters.fromJson(json['listChapters'])
          : null,
      listAudios: json['listAudios'] != null
          ? Audio.fromJson(json['listAudios'])
          : null,
    );
  }
}
