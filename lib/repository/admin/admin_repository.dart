import 'dart:convert';
import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/providers/providers.dart';
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
      SharedService.setToken(data['responseData']['token']);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Admin?> getProfile() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SharedService.getToken()}',
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
        return Admin.fromJson(data['responseData']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    SharedService.clear();
  }

  @override
  Future obtainTokenAndUserData() async {
    try {
      String? authToken = SharedService.getToken();

      if (authToken == null) {
        SharedService.setToken('');
      }
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${SharedService.getToken()}',
      };
      var url = Uri.https(
        Config.apiURL,
        '${Config.API}/admin/checkToken',
      );
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
