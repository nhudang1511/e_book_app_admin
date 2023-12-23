import 'dart:convert';
import 'dart:html' as html;
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';
import 'package:file_picker/src/platform_file.dart';

import 'base_book_repository.dart';
import 'package:http/http.dart' as http;

class BookRepository extends BaseBookRepository {
  static var client = http.Client();

  @override
  Future<List<Book>?> getAllBook() async {
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
    } else {
      return null;
    }
  }

  @override
  Future<List<ViewModel>?> getViewBooks() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(
      Config.apiURL,
      '${Config.API}/book/viewBooks',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return viewsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  @override
  Future<Book?> addBook(
    String title,
    String authodId,
    List<String> categoryId,
    String description,
    PlatformFile image,
    String language,
    List<PlatformFile> bookReview,
    int chapters,
    String country,
  ) async {
    var url = Uri.http(Config.apiURL, '${Config.API}/book/add');
    var request = http.MultipartRequest('POST', url);

    // Thêm các trường thông tin sách vào fields
    request.fields['title'] = title;
    request.fields['authodId'] = authodId;
    request.fields['categoryId'] = categoryId.join(',');

    request.fields['description'] = description;
    request.fields['language'] = language;
    request.fields['chapters'] = chapters.toString();
    request.fields['country'] = country;

    // Thêm ảnh bìa sách
    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'imageUrl',
      image.bytes!.cast(),
      filename: image.name,
    );
    request.files.add(multipartFile);

    // Thêm các tệp đánh giá sách
    for (int i = 0; i < bookReview.length; i++) {
      http.MultipartFile reviewFile = http.MultipartFile.fromBytes(
        'bookReview',
        bookReview[i].bytes!.cast(),
        filename: bookReview[i].name, // Đặt tên cho file review
      );
      request.files.add(reviewFile);
    }

    // Thêm header Authorization
    request.headers['Authorization'] =
        'Bearer ${html.window.localStorage['token']}';

    // Thêm header Content-Type
    request.headers['Content-Type'] = 'multipart/form-data';

    // Gửi yêu cầu và nhận phản hồi
    var response = await request.send();
    var multipartResponseData = await http.Response.fromStream(response);

    if (multipartResponseData.statusCode == 201) {
      var responseData = jsonDecode(multipartResponseData.body);
      return Book.fromJson(responseData['data']);
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteBook(String bookId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(
        Config.apiURL, '${Config.API}/book/delete/', {'bookId': bookId});
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
  Future<bool> removeBook(String bookId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${html.window.localStorage['token']}',
    };
    var url = Uri.http(
        Config.apiURL, '${Config.API}/book/remove/', {'bookId': bookId});
    var response = await client.delete(
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
