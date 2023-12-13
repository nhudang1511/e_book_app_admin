import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';

class UserDataTable extends StatelessWidget {
  const UserDataTable(
      {Key? key,
      required this.id,
      required this.fullName,
      required this.listUsers,
      required this.email,
      required this.phone,
      required this.status})
      : super(key: key);

  final String id, fullName, email, phone, status;
  final List<User> listUsers;

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
            DataColumn(label: Text(fullName)),
            DataColumn(label: Text(email)),
            DataColumn(label: Text(phone)),
            DataColumn(label: Text(status)),
            const DataColumn(
              label: Text('Actions'),
              numeric: true,
            ),
          ],
          source: _DataSource(listUsers),
          rowsPerPage: 5, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<User> listUsers;

  _DataSource(this.listUsers);

  @override
  DataRow getRow(int index) {
    final item = listUsers[index];
    return DataRow(cells: [
      DataCell(Text(item.id)),
      DataCell(Text(item.fullName)),
      DataCell(Text(item.email)),
      DataCell(Text(item.phoneNumber)),
      DataCell(Text(item.status.toString())),
      DataCell(
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.block, color: Colors.white),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listUsers.length;

  @override
  int get selectedRowCount => 0;
}
