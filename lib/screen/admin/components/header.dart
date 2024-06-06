import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/responsive.dart';
import 'menu_app_controller.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //if(!Responsive.isDesktop(context))
          IconButton(
              onPressed: context.read<MenuAppController>().controlMenu,
              icon: const Icon(
                Icons.menu,
              )),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticateState || state is AuthInitial) {
          Navigator.pushNamed(context, LoginScreen.routeName);
        }
      },
      builder: (context, state) {
        if (state is AuthenticateState) {
          return Row(
            children: [
              PopupMenuButton(
                  offset: const Offset(0, 60),
                  // SET THE (X,Y) POSITION
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.background,
                      size: 28,
                    ),

                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.authUser!.fullName,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              state.authUser!.email,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Divider(
                              color: Theme.of(context).colorScheme.secondary,
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                          value: 'Option 1',
                          onTap: () {
                            _authBloc.add(AuthEventLoggedOut());
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginScreen.routeName, (route) => false);
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.logout_outlined,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Logout',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )
                                ],
                              ),
                            ],
                          )),
                    ];
                  })
            ],
          );
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }
}
