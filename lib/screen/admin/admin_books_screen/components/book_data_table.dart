import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDataTable extends StatefulWidget {
  const BookDataTable({
    Key? key,
    required this.id,
    required this.name,
    required this.authorName,
    required this.view,
    required this.listBooks,
    required this.listAuthors,
    required this.listViews,
    required this.categories,
    required this.listChapters,
  }) : super(key: key);

  final String id, name, authorName, view;
  final List<Book> listBooks;
  final List<Author> listAuthors;
  final List<ViewModel> listViews;
  final List<Category> categories;
  final List<Chapters> listChapters;

  @override
  State<StatefulWidget> createState() => _BookDateTableState();
}

class _BookDateTableState extends State<BookDataTable> {
  late BookBloc bookBloc;

  @override
  void initState() {
    super.initState();
    bookBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Theme(
        data: Theme.of(context).copyWith(
          cardColor: const Color(0xFF1B2063),
          //cardTheme: CardTheme(shape: Border.all(color: Colors.white, width: 2)),
          dividerColor: Colors.white,
          dataTableTheme: const DataTableThemeData(
            dataTextStyle: TextStyle(color: Colors.white),
            headingTextStyle: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.white)),
        ),
        child: PaginatedDataTable(
          columns: [
            DataColumn(label: Text(widget.id)),
            DataColumn(label: Text(widget.name)),
            DataColumn(label: Text(widget.authorName)),
            DataColumn(label: Text(widget.view)),
            const DataColumn(
              label: Text('Actions      '),
              numeric: true,
            ),
          ],
          source: _DataSource(
              widget.listBooks,
              context,
              bookBloc,
              widget.listAuthors,
              widget.listViews,
              widget.categories,
              widget.listChapters,
              widget.listAuthors),
          rowsPerPage: 5, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Book> listBooks;
  final List<Author> listAuthors;
  final List<ViewModel> listViews;
  final List<Category> listCategories;
  final List<Chapters> chapters;
  final List<Author> listAuthor;
  final BuildContext context;
  final BookBloc bookBloc;

  _DataSource(this.listBooks, this.context, this.bookBloc, this.listAuthors,
      this.listViews, this.listCategories, this.chapters, this.listAuthor);

  @override
  DataRow getRow(int index) {
    final item = listBooks[index];
    return DataRow(cells: [
      DataCell(Text(item.id)),
      DataCell(Text(item.title)),
      DataCell(
        Text(
          (listAuthors
              .firstWhere(
                (author) => author.id == item.authodId,
                orElse: () => Author(item.authodId, 'unknown',
                    true), // Default value or handle accordingly
              )
              .fullName!),
        ),
      ),
      DataCell(
        Text(
          (listViews
                  .firstWhere(
                    (view) => view.bookId == item.id,
                    orElse: () => ViewModel(
                        item.id, 0), // Default value or handle accordingly
                  )
                  .views)
              .toString(),
        ),
      ),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BookDetail(
                        book: item,
                        categories: listCategories,
                        listChapters: chapters,
                        listAuthors: listAuthors,
                      );
                    });
              },
              icon: const Icon(Icons.description, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        content: const Text('Are you sure you want to delete?'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              bookBloc.add(DeleteBook(item.id));
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete, color: Colors.white),
            )
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listBooks.length;

  @override
  int get selectedRowCount => 0;
}
