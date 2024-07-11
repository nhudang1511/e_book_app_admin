import 'dart:convert';

import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/utils/utils.dart';

import 'base_notification_repository.dart';
import 'package:http/http.dart' as http;

class NotificationRepository extends BaseNotificationRepository {
  static var client = http.Client();

  @override
  Future sendNotification(String uId) {
    // TODO: implement sendNotification
    throw UnimplementedError();
  }

  @override
  Future sendNotificationAll(String title, String body) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/notification/sendAll');
    await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "title": title,
        "body": body,
      }),
    );
  }
}
