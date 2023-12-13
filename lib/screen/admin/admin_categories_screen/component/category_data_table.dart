import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';

class CategoryDataTable extends StatelessWidget {
  const CategoryDataTable({
    Key? key,
    required this.id,
    required this.name,
    required this.status,
    required this.listCategories,
  }) : super(key: key);

  final String id, name, status;
  final List<Category> listCategories;

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
            DataColumn(label: Text(status)),
            const DataColumn(
              label: Text('Actions     '),
              numeric: true,
            ),
          ],
          source: _DataSource(listCategories),
          rowsPerPage: 5, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Category> listCategories;

  _DataSource(this.listCategories);

  @override
  DataRow getRow(int index) {
    final item = listCategories[index];
    return DataRow(
      cells: [
        DataCell(Text(item.id)),
        DataCell(Text(item.name)),
        DataCell(Text(item.status.toString())),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listCategories.length;

  @override
  int get selectedRowCount => 0;
}
