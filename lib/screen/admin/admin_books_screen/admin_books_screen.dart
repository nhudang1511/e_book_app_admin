import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/book_data_table.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/form_add_book.dart';
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
  late AuthorBloc authorBloc;
  late ViewBloc viewBloc;
  late Book? newBook;
  late Map<String, String>? listChapter;
  late bool _isLoading = false;

  Future<void> yourAsyncFunction() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    chaptersBloc = BlocProvider.of(context);
    bookBloc = BlocProvider.of(context);
    authorBloc = BlocProvider.of(context);
    viewBloc = BlocProvider.of(context);
    newBook = null;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(builder: (context, state) {
      if (state is BookAdded) {
        newBook = state.book;
      }
      if (state is BookLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is BookLoaded) {
        List<Book> listBooks = state.books;
        authorBloc.add(LoadAuthors());
        return BlocBuilder<AuthorBloc, AuthorState>(builder: (context, state) {
          if (state is AuthorLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AuthorLoaded) {
            List<Author> listAuthors = state.authors;
            viewBloc.add(LoadView());
            return BlocBuilder<ViewBloc, ViewState>(builder: (context, state) {
              if (state is ViewLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ViewLoaded) {
                List<ViewModel> listViews = state.views;
                return BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CategoryLoaded) {
                    List<Category> listCategories = state.categories;
                    return BlocBuilder<ChaptersBloc, ChaptersState>(
                        builder: (context, state) {
                      if (state is ChaptersLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is ChaptersLoaded) {
                        return SafeArea(
                          child: Drawer(
                            backgroundColor:
                                Theme.of(context).colorScheme.onBackground,
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
                                        padding: const EdgeInsets.only(
                                            right: 30, top: 20),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            listChapter = await showDialog<
                                                Map<String, String>>(
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
                                                if (listChapter == null) {
                                                  bookBloc.add(
                                                      RemoveBook(newBook!.id));
                                                } else {
                                                  chaptersBloc.add(AddChapters(
                                                      newBook!.id,
                                                      listChapter!));
                                                  await yourAsyncFunction();
                                                }
                                              } finally {
                                                setState(() {
                                                  _isLoading = false;
                                                  newBook = null;
                                                  bookBloc.add(LoadBooks());
                                                });
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'New Book',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      _isLoading == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 30, top: 20),
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Container(
                                              padding: const EdgeInsets.only(
                                                  right: 30, top: 20),
                                              child: IconButton(
                                                onPressed: () {
                                                  bookBloc.add(LoadBooks());
                                                },
                                                icon: const Icon(Icons.refresh),
                                              ),
                                            ),
                                    ],
                                  ),
                                  BookDataTable(
                                    id: 'Book ID',
                                    name: 'Title',
                                    authorName: 'Author Name',
                                    view: 'View',
                                    listBooks: (listBooks
                                        .where((book) => book.status == true)
                                        .toList()
                                      ..sort((a, b) =>
                                          a.title.compareTo(b.title))),
                                    listAuthors: listAuthors,
                                    listViews: listViews,
                                    categories: listCategories,
                                    listChapters: state.chapters,
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
                  } else {
                    return const Text("Something went wrong");
                  }
                });
              } else {
                return const Text("Something went wrong");
              }
            });
          } else {
            return const Text("Something went wrong");
          }
        });
      } else {
        return const Text("Something went wrong");
      }
    });
  }
}
