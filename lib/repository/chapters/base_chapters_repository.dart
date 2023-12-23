import 'package:e_book_admin/model/models.dart';

abstract class BaseChaptersRepository {
  Future<List<Chapters>?> getAllChapters();
  Future<bool> addChapters (String bookId, Map<String, String> listChapters);
}