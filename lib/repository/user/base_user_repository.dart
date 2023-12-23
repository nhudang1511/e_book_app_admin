import 'package:e_book_admin/model/models.dart';

abstract class BaseUserRepository {
  Future<List<User>?> getAllUser();
  Future<bool> blockUser(String userId);
}