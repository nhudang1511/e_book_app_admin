import 'dart:convert';

import 'package:e_book_admin/items/statistic_item.dart';
import 'package:e_book_admin/repository/statistic/base_statistic_repository.dart';
import 'package:e_book_admin/utils/utils.dart';

import '../../config/share_preferences.dart';
import 'package:http/http.dart' as http;

class StatisticRepository extends BaseStatisticRepository {
  static var client = http.Client();

  @override
  Future<StatisticItem?> getStatistic() async{
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(
      Config.apiURL,
      '${Config.API}/statistic',
    );
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return StatisticItem.fromJson(data["responseData"]);
    } else {
      return null;
    }
  }

}