import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_books_screen/components/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../items/items.dart';

class BookDataTable extends StatefulWidget {
  const BookDataTable({
    Key? key,
    required this.id,
    required this.name,
    required this.authorName,
    required this.view,
    required this.listBookItems,
    required this.totalBook,
    required this.onChangedPage,
  }) : super(key: key);

  final String id, name, authorName, view;
  final List<BookItem> listBookItems;
  final int totalBook;
  final Function(int) onChangedPage;

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
          cardColor: Theme.of(context).colorScheme.background,
          //cardTheme: CardTheme(shape: Border.all(color: Colors.white, width: 2)),
          dividerColor: Theme.of(context).colorScheme.secondary,
          dataTableTheme: DataTableThemeData(
            dataTextStyle: Theme.of(context).textTheme.titleLarge,
            headingTextStyle: Theme.of(context).textTheme.headlineMedium,
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          textTheme: const TextTheme(
            bodySmall: TextStyle(color: Colors.black),
          ),
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
            widget.listBookItems,
            context,
            bookBloc,
            widget.totalBook,
          ),
          rowsPerPage: 5,
          onPageChanged: widget
              .onChangedPage, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<BookItem> listBookItems;
  final BuildContext context;
  final BookBloc bookBloc;
  final int totalBook;

  _DataSource(
    this.listBookItems,
    this.context,
    this.bookBloc,
    this.totalBook,
  );

  @override
  DataRow getRow(int index) {
    final item = listBookItems[index % 5];
    return DataRow(cells: [
      DataCell(Text(item.id)),
      DataCell(Text(item.title)),
      DataCell(
        Text(item.author.fullName!),
      ),
      DataCell(
        Text(item.view.toString()),
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
                        id: item.id,
                      );
                    });
              },
              icon: const Icon(
                Icons.description,
              ),
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
              icon: const Icon(
                Icons.delete,
              ),
            )
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalBook;

  @override
  int get selectedRowCount => 0;
}
