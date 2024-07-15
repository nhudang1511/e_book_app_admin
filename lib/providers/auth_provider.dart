import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:flutter/material.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  final AdminRepository _adminRepository = AdminRepository();
  Admin? _admin;

  Status get status => _status;

  Admin? get user => _admin;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthProvider.initialize() {
    _setup();
  }

  _setup() async {
    await SharedService.init();

    String? token = SharedService.getToken();

    if (token != null) {
      if (await _adminRepository.obtainTokenAndUserData() == true) {
        _admin = await _adminRepository.getProfile();
        _status = Status.Authenticated;
      } else {
        _status = Status.Unauthenticated;
      }
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> logIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();

      var result = await _adminRepository.login(
        email.text.trim(),
        password.text.trim(),
      );
      if (result == true) {
        await _setup();
        notifyListeners();
        return true;
      } else {
        await _setup();
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    await _adminRepository.signOut();
    await _setup();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    password.text = "";
    email.text = "";
  }
}
