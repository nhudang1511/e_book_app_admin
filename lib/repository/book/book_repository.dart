import 'dart:convert';
import 'package:e_book_admin/items/book_detail_item.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/utils/utils.dart';
import 'package:file_picker/file_picker.dart';

import '../../config/share_preferences.dart';
import 'base_book_repository.dart';
import 'package:http/http.dart' as http;

class BookRepository extends BaseBookRepository {
  static var client = http.Client();

  @override
  Future<Map<String, dynamic>?> getAllBook([int currentPage = 1]) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/book/', {
      'currentPage': currentPage.toString(),
    });
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["responseData"];
    } else {
      return null;
    }
  }

  @override
  Future<BookDetailItem?> getBook(String id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/book/get', {
      'bookId': id,
    });
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return BookDetailItem.fromJson(data["responseData"]);
    } else {
      return null;
    }
  }

  @override
  Future<List<ViewModel>?> getViewBooks() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/book/viewBooks',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return viewsFromJson(data["responseData"]);
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
    int price,
    PlatformFile image,
    String language,
    List<PlatformFile> bookReview,
    int chapters,
    String country,
  ) async {
    var url = Uri.https(Config.apiURL, '${Config.API}/book/add');
    var request = http.MultipartRequest('POST', url);

    request.fields['title'] = title;
    request.fields['authodId'] = authodId;
    request.fields['categoryId'] = categoryId.join(',');

    request.fields['description'] = description;
    request.fields['price'] = price.toString();
    request.fields['language'] = language;
    request.fields['chapters'] = chapters.toString();
    request.fields['country'] = country;

    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'imageUrl',
      image.bytes!.cast(),
      filename: image.name,
    );
    request.files.add(multipartFile);

    for (int i = 0; i < bookReview.length; i++) {
      http.MultipartFile reviewFile = http.MultipartFile.fromBytes(
        'bookReview',
        bookReview[i].bytes!.cast(),
        filename: bookReview[i].name,
      );
      request.files.add(reviewFile);
    }

    request.headers['Authorization'] = 'Bearer ${SharedService.getToken()}';

    request.headers['Content-Type'] = 'multipart/form-data';

    // Gửi yêu cầu và nhận phản hồi
    var response = await request.send();
    var multipartResponseData = await http.Response.fromStream(response);

    if (multipartResponseData.statusCode == 201) {
      var responseData = jsonDecode(multipartResponseData.body);
      return Book.fromJson(responseData['responseData']);
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteBook(String bookId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
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
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
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
