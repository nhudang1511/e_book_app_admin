import 'package:e_book_admin/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_book_admin/blocs/blocs.dart';

class UserDataTable extends StatefulWidget {
  const UserDataTable(
      {Key? key,
      required this.id,
      required this.displayName,
      required this.listUsers,
      required this.email,
      required this.status})
      : super(key: key);

  final String id, displayName, email, status;
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
            DataColumn(label: Text(widget.displayName)),
            DataColumn(label: Text(widget.email)),
            DataColumn(label: Text(widget.status)),
            const DataColumn(
              label: Text('Enable'),
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
      DataCell(Text(item.displayName!= null ? item.displayName! : "Null")),
      DataCell(Text(item.email)),
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
          icon: const Icon(
            Icons.block,
          ),
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
