import 'package:e_book_admin/model/models.dart';

abstract class BaseAuthorRepository {
  Future<List<Author>?> getAllAuthor();
}