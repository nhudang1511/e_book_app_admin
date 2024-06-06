import 'package:e_book_admin/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../screen/screen.dart';
import 'dart:html' as html;

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return _route(const LoginScreen());
      case AdminPanel.routeName:
        return _route(const AdminPanel());
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
            ));
  }

  static Route _route(screen) {
    if (html.window.localStorage['token'] == null) {
      return MaterialPageRoute(
          settings: const RouteSettings(name: LoginScreen.routeName),
          builder: (context) => const LoginScreen());
    }
    else {
      return MaterialPageRoute(builder: (context) => screen);
    }
  }
}
