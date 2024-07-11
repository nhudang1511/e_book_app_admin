import 'package:flutter/material.dart';

import '../../../config/responsive.dart';

class SliderMenu extends StatelessWidget {
  const SliderMenu({
    super.key,
    required TabController tabController,
    required int selectedTabIndex,
  })  : _tabController = tabController,
        _selectedTabIndex = selectedTabIndex;

  final TabController _tabController;
  final int _selectedTabIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/logo/logo.png'),
            ),
            DrawerListTile(
              title: 'Dashboard',
              icons: Icons.dashboard_rounded,
              press: () {
                _tabController.animateTo(0);
              },
              isSelected: _selectedTabIndex == 0,
            ),
            DrawerListTile(
              title: 'Categories',
              icons: Icons.category_rounded,
              press: () {
                _tabController.animateTo(1);
              },
              isSelected: _selectedTabIndex == 1,
            ),
            DrawerListTile(
              title: 'Books',
              icons: Icons.menu_book_sharp,
              press: () {
                _tabController.animateTo(2);
              },
              isSelected: _selectedTabIndex == 2,
            ),
            DrawerListTile(
              title: 'Users',
              icons: Icons.person,
              press: () {
                _tabController.animateTo(3);
              },
              isSelected: _selectedTabIndex == 3,
            ),
            DrawerListTile(
              title: 'Missions',
              icons: Icons.task_alt,
              press: () {
                _tabController.animateTo(4);
              },
              isSelected: _selectedTabIndex == 4,
            ),
            // DrawerListTile(
            //   title: 'Sales',
            //   icons: Icons.monetization_on,
            //   press: () {
            //     _tabController.animateTo(5);
            //   },
            //   isSelected: _selectedTabIndex == 5,
            // ),
            if (!Responsive.isDesktop(context))
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icons,
    required this.press,
    required this.isSelected,
  });

  final String title;
  final IconData icons;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        press();
        Navigator.of(context).pop();
      },
      horizontalTitleGap: 0.0,
      leading: Icon(
        icons,
        color: isSelected
            ? Theme.of(context).colorScheme.secondaryContainer
            : Colors.black,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Colors.black,
            ),
      ),
    );
  }
}
