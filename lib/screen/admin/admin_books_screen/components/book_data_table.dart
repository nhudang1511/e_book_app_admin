import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDataTable extends StatelessWidget {
  const BookDataTable({
    Key? key,
    required this.id,
    required this.name,
    required this.authorName,
    required this.status,
    required this.listBooks,
  }) : super(key: key);

  final String id, name, authorName, status;
  final List<Book> listBooks;

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
            DataColumn(label: Text(id)),
            DataColumn(label: Text(name)),
            DataColumn(label: Text(authorName)),
            DataColumn(label: Text(status)),
            const DataColumn(
              label: Text('Actions          '),
              numeric: true,
            ),
          ],
          source: _DataSource(listBooks),
          rowsPerPage: 5, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Book> listBooks;

  _DataSource(this.listBooks);

  @override
  DataRow getRow(int index) {
    final item = listBooks[index];
    return DataRow(cells: [
      DataCell(Text(item.id)),
      DataCell(Text(item.title)),
      DataCell(
        BlocBuilder<AuthorBloc, AuthorState>(
          builder: (context, state) {
            if (state is AuthorLoading) {
              return const CircularProgressIndicator();
            }
            if (state is AuthorLoaded) {
              Author? author = state.authors.firstWhere(
                (author) => author.id == item.authodId,
              );
              return Text(author.fullName!);
            } else {
              return const Text("Something went wrong");
            }
          },
        ),
      ),
      DataCell(Text(item.status.toString())),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.description, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
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
