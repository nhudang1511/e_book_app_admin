import 'package:e_book_admin/entities/entities.dart';
import 'package:e_book_admin/model/models.dart';

List<BookItem> bookItemsFromJson(dynamic str) =>
    List<BookItem>.from((str).map((x) => BookItem.fromJson(x)));

class BookItem extends BookEntity {
  BookItem({
    required super.id,
    required super.author,
    required super.price,
    required super.title,
    required super.view,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json['id'] ?? '',
      author: Author.fromJson(json['author']),
      price: json['price'] ?? '',
      title: json['title'] ?? '',
      view: json['view'] ?? '',
    );
  }
}
