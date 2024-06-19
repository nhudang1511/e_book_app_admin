import 'dart:convert';
import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';

import 'base_author_repository.dart';
import 'package:http/http.dart' as http;

class AuthorRepository extends BaseAuthorRepository {
  static var client = http.Client();

  @override
  Future<List<Author>?> getAllAuthor() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/author/',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return authorsFromJson(data["responseData"]);

    } else {
      return null;
    }
  }

}