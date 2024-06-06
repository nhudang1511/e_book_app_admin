import 'dart:convert';
import 'dart:html' as html;
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';

import 'base_user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepository extends BaseUserRepository {
  static var client = http.Client();

  @override
  Future<List<User>?> getAllUser() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/user',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return usersFromJson(data["data"]);
    } else {
      return null;
    }
  }

  @override
  Future<bool> blockUser(String userId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url =
        Uri.https(Config.apiURL, '${Config.API}/user/block/', {'userId': userId});
    var response = await client.put(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;

      //return true;
    } else {
      return false;
    }
  }
}
