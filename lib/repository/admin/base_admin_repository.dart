import 'package:e_book_admin/model/models.dart';

abstract class BaseAdminRepository {
  Future<bool> login(String email, String passWord);
  Future<Admin?> getProfile();
  Future<void> signOut();
}