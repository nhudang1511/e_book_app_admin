import 'package:e_book_admin/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_book_admin/screen/screen.dart';
import 'package:e_book_admin/config/routes/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return _getPageRoute(const LoginScreen());
    case adminRoute:
      return _getPageRoute(const AdminPanel());
    default:
      return _getPageRoute(const LoginScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
