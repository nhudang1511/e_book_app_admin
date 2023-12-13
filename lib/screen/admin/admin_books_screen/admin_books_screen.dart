import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/book_data_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/admin_model.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';
class AdminBooksScreen extends StatelessWidget {
  const AdminBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is BookLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is BookLoaded) {
        return SafeArea(
            child: Drawer(
              backgroundColor: const Color(0xFF1B2063),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Header(
                      title: 'Books',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 30, top: 20),
                          child: ElevatedButton(
                              onPressed: () {}, child: const Text('New')),
                        ),
                      ],
                    ),
                    BookDataTable (
                      id: 'Book ID',
                      name: 'Title',
                      authorName: 'Author Name',
                      status: 'Status',
                      listBooks: state.books,
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
