import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_book_admin/blocs/blocs.dart';

class UserDataTable extends StatefulWidget {
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
  State<StatefulWidget> createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of(context);
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
            DataColumn(label: Text(widget.fullName)),
            DataColumn(label: Text(widget.email)),
            DataColumn(label: Text(widget.phone)),
            DataColumn(label: Text(widget.status)),
            const DataColumn(
              label: Text('Actions'),
              numeric: true,
            ),
          ],
          source: _DataSource(widget.listUsers, userBloc, context),
          rowsPerPage: 5, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<User> listUsers;
  final UserBloc userBloc;
  final BuildContext context;

  _DataSource(this.listUsers, this.userBloc, this.context);

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
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  content: const Text('Are you sure you want to block?'),
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
                        userBloc.add(BlockUser(item.id));
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
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
