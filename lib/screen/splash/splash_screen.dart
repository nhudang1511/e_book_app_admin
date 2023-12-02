import 'dart:async';
import 'package:flutter/material.dart';

import '../admin/admin_panel.screen.dart';
class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SplashScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushNamedAndRemoveUntil(context, AdminPanel.routeName, (route) => false));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(image: AssetImage('assets/logo/logo.png')),
          ),
        ],
      ),
    );
  }
}
