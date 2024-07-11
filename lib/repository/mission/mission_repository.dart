import 'dart:convert';
import 'package:e_book_admin/model/mission_model.dart';
import 'package:e_book_admin/utils/utils.dart';

import '../../config/share_preferences.dart';
import 'base_mission_repository.dart';
import 'package:http/http.dart' as http;

class MissionRepository extends BaseMissionRepository {
  static var client = http.Client();

  @override
  Future<List<Mission>?> getAllMissions() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/mission');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return missionsFromJson(data["responseData"]);
    } else {
      return null;
    }
  }

  @override
  Future<Mission?> addMission(
    String name,
    String detail,
    int coins,
    String type,
    int times,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/mission/add/');
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'name': name,
        'detail': detail,
        'coins': coins,
        'type': type,
        'times': times,
      }),
    );
    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return Mission.fromJson(responseData["responseData"]);
    } else {
      return null;
    }
  }

  @override
  Future<bool> updateMission(String id, String name, String detail, int coins,
      String type, int times) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/mission/update/', {
      'missionId': id,
    });
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'name': name,
        'detail': detail,
        'coins': coins,
        'type': type,
        'times': times,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteMission(String id) async{
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${SharedService.getToken()}',
    };
    var url = Uri.https(Config.apiURL, '${Config.API}/mission/delete/', {
      'missionId': id,
    });
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
