import 'package:e_book_admin/screen/admin/admin_coins_screen/admin_coins_screen.dart';
import 'package:e_book_admin/screen/admin/admin_missions_screen/admin_missions_screen.dart';
import 'package:flutter/material.dart';
import '../../config/responsive.dart';
import 'admin_books_screen/admin_books_screen.dart';
import 'admin_categories_screen/admin_categories_screen.dart';
import 'admin_contact_screen/admin_contact_screen.dart';
import 'admin_users_screen/admin_users_screen.dart';
import 'components/menu_app_controller.dart';
import 'components/slider_menu.dart';
import 'dashboard/dashboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  static const String routeName = '/admin_panel';

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0; // Biến để theo dõi tab hiện tại

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // 4 tabs

    // Add listener to switch tabs when DrawerListTile is pressed
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // You can add logic here to perform actions when switching tabs
      }
      setState(() {
        _selectedTabIndex = _tabController.index; // Cập nhật tab hiện tại
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SliderMenu(
          tabController: _tabController, selectedTabIndex: _selectedTabIndex),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        DashboardScreen(),
                        AdminCategoriesScreen(),
                        AdminBooksScreen(),
                        AdminUsersScreen(),
                        AdminMissionsScreen(),
                        AdminContactScreen()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
