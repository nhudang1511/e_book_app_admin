import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:e_book_admin/screen/screen.dart';
import 'package:e_book_admin/config/routes/route_names.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _getPageRoute(const AppPagesController(), settings);
    case loginRoute:
      return _getPageRoute(const LoginScreen(), settings);
    case adminRoute:
      return _getPageRoute(const AdminPanel(), settings);
    default:
      return _errorRoute();
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  // if (SharedService.getToken() != null) {
    return MaterialPageRoute(
      builder: (context) => child,
      settings: settings,
    );
  // } else {
  //   return MaterialPageRoute(
  //     builder: (context) => const LoginScreen(),
  //     settings: const RouteSettings(name: loginRoute),
  //   );
  // }
}

Route _errorRoute() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: '/error'),
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
    ),
  );
}
