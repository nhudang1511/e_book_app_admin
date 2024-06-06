import 'dart:convert';
import 'dart:html' as html;
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';

import 'base_admin_repository.dart';
import 'package:http/http.dart' as http;

class AdminRepository extends BaseAdminRepository {
  static var client = http.Client();

  @override
  Future<bool> login(String email, String passWord) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/admin/login');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'email': email,
        'password': passWord,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      html.window.localStorage['token'] = data['token'];
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Admin?> getProfile() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/admin/profile/',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Admin.fromJson(data['data']);
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    html.window.localStorage.remove('token');
  }
}
