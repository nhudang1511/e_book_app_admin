import 'package:e_book_admin/model/models.dart';
import 'package:file_picker/file_picker.dart';

abstract class BaseBookRepository {
  Future<List<Book>?> getAllBook();

  Future<List<ViewModel>?> getViewBooks();

  Future<Book?> addBook(
      String title,
      String authodId,
      List<String> categoryId,
      String description,
      PlatformFile image,
      String language,
      List<PlatformFile> bookReview,
      int chapters,
      String country);

  Future<bool> deleteBook(String bookId);
  Future<bool> removeBook(String bookId);
}
