import 'package:e_book_admin/entities/entities.dart';
import 'package:e_book_admin/model/models.dart';
List<ContactItem> contactItemsFromJson(dynamic str) =>
    List<ContactItem>.from((str).map((x) => ContactItem.fromJson(x)));
class ContactItem extends ContactEntity {
  ContactItem({
    required super.id,
    required super.user,
    required super.content,
    required super.type,
    required super.status,
  });
  
  factory ContactItem.fromJson(Map<String, dynamic> json) {
    return ContactItem(
        id: json['id'] ?? '',
        user: User.fromJson(json['user']),
        content: json['content'] ?? '',
        type: json['type'] ?? '',
        status: json['status'] ,
    );
  }
}
