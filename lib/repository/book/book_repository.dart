import 'dart:convert';
import 'dart:html' as html;
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';

import 'base_book_repository.dart';
import 'package:http/http.dart' as http;

class BookRepository extends BaseBookRepository {
  static var client = http.Client();
  @override
  Future<List<Book>?> getAllBook() async{
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(
      Config.apiURL,
      '${Config.API}/book',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return booksFromJson(data["data"]);

      //return true;
    } else {
      return null;
    }
  }

}