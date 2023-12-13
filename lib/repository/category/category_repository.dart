import 'dart:convert';
import 'dart:html' as html;
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';

import 'base_category_repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends BaseCategoryRepository {
  static var client = http.Client();

  @override
  Future<List<Category>?> getAllCategory() async{
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(
      Config.apiURL,
      '${Config.API}/category',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return categoriesFromJson(data["data"]);

      //return true;
    } else {
      return null;
    }
  }
}
