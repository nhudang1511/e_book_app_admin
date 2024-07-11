import 'package:e_book_admin/blocs/audio/audio_bloc.dart';
import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/cubits/cubit.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:e_book_admin/screen/admin/components/menu_app_controller.dart';
import 'package:e_book_admin/screen/screen.dart';
import 'package:e_book_admin/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes/router.dart';
import 'config/theme/theme.dart';
import 'providers/providers.dart';

Future<void> main() async {
  await SharedService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        ChangeNotifierProvider.value(value: AuthProvider.initialize()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginCubit(
            adminRepository: AdminRepository(),
          ),
          child: const LoginScreen(),
        ),
        BlocProvider(
          create: (_) => AuthorBloc(
            authorRepository: AuthorRepository(),
          )..add(
              LoadAuthors(),
            ),
        ),
        BlocProvider(
          create: (_) => BookBloc(
            bookRepository: BookRepository(),
          )..add(
              LoadBooks(),
            ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategory(),
            ),
        ),
        BlocProvider(
          create: (_) => ChaptersBloc(
            chaptersRepository: ChaptersRepository(),
          )..add(
              LoadChapters(),
            ),
        ),
        BlocProvider(
          create: (_) => UserBloc(
            userRepository: UserRepository(),
          )..add(
              LoadUser(),
            ),
        ),
        BlocProvider(
          create: (_) => ViewBloc(
            bookRepository: BookRepository(),
          )..add(
              LoadView(),
            ),
        ),
        BlocProvider(
          create: (_) => MissionBloc(
            missionRepository: MissionRepository(),
          )..add(
              LoadMissions(),
            ),
        ),BlocProvider(
          create: (_) => AudioBloc(
            audioRepository: AudioRepository(),
          )..add(
            LoadAudio(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'E Book App Admin',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        initialRoute: '/',
        onGenerateRoute: (settings) => generateRoute(settings),
      ),
    );
  }
}

class AppPagesController extends StatefulWidget {
  const AppPagesController({super.key});

  @override
  State<StatefulWidget> createState() => _AppPagesControllerState();
}

class _AppPagesControllerState extends State<AppPagesController> {
  late Future _future;
  final AdminRepository _adminRepository = AdminRepository();

  @override
  void initState() {
    super.initState();
    _future = obtainTokenAndUserData();
  }

  obtainTokenAndUserData() async {
    await _adminRepository.obtainTokenAndUserData();
    if (SharedService.getToken() != null) {
      await _adminRepository.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Something went wrong")],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          switch (authProvider.status) {
            case Status.Uninitialized:
              return const Loading();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return const LoginScreen();
            case Status.Authenticated:
              return const AdminPanel();
            default:
              return const LoginScreen();
          }
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Loading();
      },
    );
  }
}
