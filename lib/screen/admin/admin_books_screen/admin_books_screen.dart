import 'package:e_book_admin/blocs/audio/audio_bloc.dart';
import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/book_data_table.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_book.dart';
import 'package:e_book_admin/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import '../components/header.dart';

class AdminBooksScreen extends StatefulWidget {
  const AdminBooksScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminBooksScreenState();
}

class _AdminBooksScreenState extends State<AdminBooksScreen> {
  late ChaptersBloc chaptersBloc;
  late BookBloc bookBloc;
  late AudioBloc audioBloc;
  late Book? newBook;
  late bool _isLoading = false;

  Future<void> yourAsyncFunction() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    chaptersBloc = BlocProvider.of(context);
    bookBloc = BlocProvider.of(context);
    audioBloc = BlocProvider.of(context);
    newBook = null;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is BookAdded) {
        newBook = state.book;
      }
      if (state is BookLoading || _isLoading == true) {
        return const Loading();
      }
      if (state is BookLoaded) {
        return SafeArea(
          child: Drawer(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
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
                          onPressed: () async {
                            final result = await showDialog<
                                Map<String, Map<String, dynamic>>>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const FormAddBook();
                              },
                            );
                            if (newBook != null) {
                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                if (result == null) {
                                  bookBloc.add(RemoveBook(newBook!.id));
                                } else {
                                  chaptersBloc.add(AddChapters(
                                      newBook!.id,
                                      Map<String, String>.from(
                                          result['listChapters']!)));
                                  await yourAsyncFunction();
                                  audioBloc.add(AddAudio(
                                      newBook!.id,
                                      Map<String, PlatformFile>.from(
                                          result['listAudios']!)));
                                  await yourAsyncFunction();
                                }
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                  newBook = null;
                                  bookBloc.add(const LoadBooks());
                                });
                              }
                            }
                          },
                          child: const Text(
                            'New Book',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  BookDataTable(
                    id: 'Book ID',
                    name: 'Title',
                    authorName: 'Author Name',
                    view: 'View',
                    listBookItems: state.books,
                    totalBook: state.totalBook,
                    onChangedPage: (index) {
                      bookBloc.add(LoadBooks(currentPage: index ~/ 5 + 1));
                    },
                  )
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
