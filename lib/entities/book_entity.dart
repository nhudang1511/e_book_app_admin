import '../model/models.dart';

class BookEntity {
  final String id;
  final Author author;
  final int price;
  final String title;
  final int view;

  BookEntity({
    required this.id,
    required this.author,
    required this.price,
    required this.title,
    required this.view,
  });
}
