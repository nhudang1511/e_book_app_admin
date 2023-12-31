import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/config/app_route.dart';
import 'package:e_book_admin/cubits/cubit.dart';
import 'package:e_book_admin/repository/repositories.dart';
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
        BlocProvider(
          create: (_) => LoginCubit(
            adminRepository: AdminRepository(),
          ),
          child: const LoginScreen(),
        ),
        BlocProvider(
          create: (_) => AuthBloc(adminRepository: AdminRepository())
            ..add(AuthEventStarted()),
        ),
        BlocProvider(
          create: (_) => AuthorBloc(authorRepository: AuthorRepository())
            ..add(LoadAuthors()),
        ),
        BlocProvider(
          create: (_) => BookBloc(bookRepository: BookRepository())
            ..add(LoadBooks()),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(categoryRepository: CategoryRepository())
            ..add(LoadCategory()),
        ),
        BlocProvider(
          create: (_) => ChaptersBloc(chaptersRepository: ChaptersRepository())
            ..add(LoadChapters()),
        ),
        BlocProvider(
          create: (_) => UserBloc(userRepository: UserRepository())
            ..add(LoadUser()),
        ),
        BlocProvider(
          create: (_) => ViewBloc(bookRepository: BookRepository())
            ..add(LoadView()),
        ),
      ],
      child: MaterialApp(
        title: 'E Book App Admin',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const LoginScreen(),
        darkTheme: darkTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
