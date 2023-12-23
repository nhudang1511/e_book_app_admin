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
          backgroundColor: const Color(0xFF1B2063),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Header(
                  title: 'Users',
                ),
                UserDataTable(
                  id: 'User ID',
                  fullName: 'Full name',
                  email: 'Email',
                  phone: 'Phone number',
                  status: 'Status',
                  listUsers: state.users
                    ..sort((a, b) => a.fullName.compareTo(b.fullName)),
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
