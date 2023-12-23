import 'package:e_book_admin/blocs/blocs.dart';
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
      color: const Color(0xFF601DB2),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //if(!Responsive.isDesktop(context))
          IconButton(
              onPressed: context.read<MenuAppController>().controlMenu,
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              )),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white),
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
class _ProfileCardState extends State<ProfileCard>{
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
          Navigator.pushNamed(context, "/login");
        }
      },
      builder: (context, state) {
        if (state is AuthenticateState) {
          return Row(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary,)),
              const SizedBox(
                width: 10,
              ),
              if (!Responsive.isMobile(context))
                Text(
                  state.authUser!.fullName,
                  style: const TextStyle(color: Colors.white),
                ),
              PopupMenuButton(
                  offset: const Offset(0, 60),
                  // SET THE (X,Y) POSITION
                  iconSize: 30,
                  color: const Color(0xFF601DB2),
                  icon: const Icon(
                    Icons.keyboard_arrow_down, // CHOOSE YOUR CUSTOM ICON
                    color: Colors.white,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.authUser!.fullName,
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                state.authUser!.email,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Divider(
                                color: Colors.white,
                                height: 5,
                              )
                            ],
                          )),
                      PopupMenuItem(
                          value: 'Option 1',
                          onTap: (){
                            _authBloc.add(AuthEventLoggedOut());
                            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                          },
                          child: const Column(
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.logout_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
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
