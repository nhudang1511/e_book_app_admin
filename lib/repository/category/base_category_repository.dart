
import 'package:e_book_admin/model/models.dart';
import 'package:file_picker/file_picker.dart';

abstract class BaseCategoryRepository {
  Future<List<Category>?> getAllCategory();
  Future<Category?> addCategory(String name, PlatformFile image);
  Future<bool> updateCategory (String categoryId, String name, PlatformFile? image);
  Future<bool> deleteCategory(String categoryId);
}