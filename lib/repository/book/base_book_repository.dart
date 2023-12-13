import 'package:e_book_admin/model/models.dart';

abstract class BaseBookRepository {
  Future<List<Book>?> getAllBook();
}