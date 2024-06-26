import 'package:e_book_admin/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/header.dart';
import 'components/user_data_table.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is UserLoaded) {
        return SafeArea(
            child: Drawer(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(
                  title: 'Users',
                ),
                UserDataTable(
                  id: 'User ID',
                  displayName: 'Full name',
                  email: 'Email',
                  status: 'Status',
                  listUsers: state.users
                    ..sort((a, b) => (a.displayName ?? 'Null').compareTo(b.displayName ?? 'Null')),
                )
              ],
            ),
          ),
        ));
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}
