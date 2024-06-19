import 'package:e_book_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                      authProvider.user!.fullName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      authProvider.user!.email,
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
                onTap: () async {
                  await authProvider.signOut();
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
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
