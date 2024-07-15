import 'dart:convert';

import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/items/contact_item.dart';
import 'package:e_book_admin/repository/contact/base_contact_repository.dart';
import 'package:e_book_admin/utils/utils.dart';
import 'package:http/http.dart' as http;

class ContactRepository extends BaseContactRepository {
  static var client = http.Client();

  @override
  Future<List<ContactItem>?> getAllContact() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/contact/',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return contactItemsFromJson(data["responseData"]);
    } else {
      return null;
    }
  }

  @override
  Future<bool> updateContact(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url =
        Uri.https(Config.apiURL, '${Config.API}/contact/update', {'id': id});
    var response = await client.put(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
