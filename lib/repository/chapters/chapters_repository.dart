import 'dart:convert';
import 'dart:html' as html;
import 'package:e_book_admin/utils/utils.dart';
import 'package:e_book_admin/model/chapters_model.dart';

import 'base_chapters_repository.dart';
import 'package:http/http.dart' as http;

class ChaptersRepository extends BaseChaptersRepository {
  static var client = http.Client();

  @override
  Future<List<Chapters>?> getAllChapters() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(
      Config.apiURL,
      '${Config.API}/chapters',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return chaptersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  @override
  Future<bool> addChapters(String bookId, Map<String, String> listChapters) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(Config.apiURL, '${Config.API}/chapters/add/');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'bookId': bookId,
          'chapterList': listChapters
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
