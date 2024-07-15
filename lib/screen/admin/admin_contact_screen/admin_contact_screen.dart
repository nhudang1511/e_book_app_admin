import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_contact_screen/component/contact_data_table.dart';
import 'package:e_book_admin/screen/admin/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminContactScreen extends StatefulWidget {
  const AdminContactScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminContactScreenState();
}

class _AdminContactScreenState extends State<AdminContactScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
      if (state is ContactLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ContactLoaded) {
        return SafeArea(
          child: Drawer(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Header(
                    title: 'Questions',
                  ),
                  ContactDataTable(
                    email: 'Email',
                    type: 'Type',
                    listContacts: state.contacts,
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}
