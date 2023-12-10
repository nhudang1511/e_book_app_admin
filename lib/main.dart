import 'package:e_book_admin/screen/admin/admin_panel.screen.dart';
import 'package:e_book_admin/screen/admin/components/menu_app_controller.dart';
import 'package:e_book_admin/screen/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'config/theme/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuAppController()),
      ],
      child: MaterialApp(
        title: 'E Book App Admin',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const LoginScreen(),
        darkTheme: darkTheme,
      ),
    );
  }
}
