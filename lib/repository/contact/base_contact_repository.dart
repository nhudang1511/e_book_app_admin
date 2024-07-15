
import 'package:e_book_admin/items/items.dart';

abstract class BaseContactRepository {
  Future<List<ContactItem>?> getAllContact();
  Future<bool> updateContact(String id);
}