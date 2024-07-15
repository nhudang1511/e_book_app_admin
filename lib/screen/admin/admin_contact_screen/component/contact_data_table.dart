import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/items/items.dart';
import 'package:e_book_admin/screen/admin/admin_contact_screen/component/form_detail_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDataTable extends StatefulWidget {
  const ContactDataTable({
    Key? key,
    required this.email,
    required this.type,
    required this.listContacts,
  }) : super(key: key);

  final String email, type;
  final List<ContactItem> listContacts;

  @override
  State<StatefulWidget> createState() => _ContactDataTableState();
}

class _ContactDataTableState extends State<ContactDataTable> {
  late ContactBloc contactBloc;

  @override
  void initState() {
    super.initState();
    contactBloc = BlocProvider.of(context);
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
            DataColumn(
              label: Text(widget.email),
            ),
            DataColumn(
              label: Text(widget.type),
            ),
            const DataColumn(
              label: Text('Actions     '),
              numeric: true,
            ),
          ],
          source: _DataSource(widget.listContacts, contactBloc, context),
          rowsPerPage: 5,
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<ContactItem> listContacts;
  final ContactBloc contactBloc;
  final BuildContext context;

  _DataSource(this.listContacts, this.contactBloc, this.context);

  @override
  DataRow getRow(int index) {
    final item = listContacts[index];
    return DataRow(
      cells: [
        DataCell(SelectableText(item.user.email)),
        DataCell(
          Text(item.type),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(
              right: 32.0,
            ),
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ContactDetail(
                        contact: item,
                      );
                    });
              },
              icon: const Icon(Icons.description),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => listContacts.length;

  @override
  int get selectedRowCount => 0;
}
