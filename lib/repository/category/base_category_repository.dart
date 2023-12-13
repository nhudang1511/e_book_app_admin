import 'package:e_book_admin/model/models.dart';

abstract class BaseCategoryRepository {
  Future<List<Category>?> getAllCategory();
}