import 'dart:convert';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';
import 'package:file_picker/file_picker.dart';

import '../../config/share_preferences.dart';
import 'base_category_repository.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends BaseCategoryRepository {
  static var client = http.Client();

  @override
  Future<List<Category>?> getAllCategory() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/category',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return categoriesFromJson(data["responseData"]);
    } else {
      return null;
    }
  }

  @override
  Future<Category?> addCategory(String name, PlatformFile image) async {
    var url = Uri.https(Config.apiURL, '${Config.API}/category/add');
    var request = http.MultipartRequest('POST', url);
    request.fields['name'] = name;
    request.fields['status'] = 'true';
    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'imageUrl',
      image.bytes!.cast(),
      filename: image.name,
    );
    request.headers['Authorization'] =
        'Bearer ${SharedService.getToken()}';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.files.add(multipartFile);
    var response = await request.send();
    var multipartResponseData = await http.Response.fromStream(response);

    if (multipartResponseData.statusCode == 201) {
      var responseData = jsonDecode(multipartResponseData.body);
      return Category.fromJson(responseData['data']);
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteCategory(String categoryId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/category/delete/', {
      'categoryId': categoryId,
    });
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

  @override
  Future<bool> updateCategory(
      String categoryId, String name, PlatformFile? image) async {
    var url = Uri.https(Config.apiURL, '${Config.API}/category/update/', {
      'categoryId': categoryId,
    });
    var request = http.MultipartRequest('PUT', url);
    request.fields['name'] = name;
    request.fields['status'] = 'true';
    if (image != null) {
      http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
        'imageUrl',
        image.bytes!.cast(),
        filename: image.name,
      );
      request.files.add(multipartFile);
    }
    request.headers['Authorization'] =
        'Bearer ${SharedService.getToken()}';
    request.headers['Content-Type'] = 'multipart/form-data';
    var response = await request.send();

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
