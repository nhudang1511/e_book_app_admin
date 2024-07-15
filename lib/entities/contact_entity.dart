import 'package:e_book_admin/model/models.dart';

class ContactEntity {
  final String id;
  final User user;
  final String content;
  final String type;
  final bool status;

  ContactEntity({
    required this.id,
    required this.user,
    required this.content,
    required this.type,
    required this.status,
  });
}
