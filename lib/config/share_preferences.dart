import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String? getToken() {
    return _pref.getString("token");
  }

  static void setToken(String token) {
    _pref.setString("token", token);
  }
  static void clear(){
    _pref.clear();
  }
}
