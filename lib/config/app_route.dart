import 'package:flutter/material.dart';

import '../screen/admin/admin_panel.screen.dart';
import '../screen/splash/splash_screen.dart';

class AppRouter{
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return AdminPanel.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case AdminPanel.routeName:
        return AdminPanel.route();
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Error'),),
        ));
  }
}