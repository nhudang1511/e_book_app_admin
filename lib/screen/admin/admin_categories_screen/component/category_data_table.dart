import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/model/models.dart';
import 'package:e_book_admin/screen/admin/admin_categories_screen/component/form_edit_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDataTable extends StatefulWidget {
  const CategoryDataTable({
    Key? key,
    required this.id,
    required this.name,
    required this.listCategories,
  }) : super(key: key);

  final String id, name;
  final List<Category> listCategories;

  @override
  State<StatefulWidget> createState() => _CategoryDataTableState();
}

class _CategoryDataTableState extends State<CategoryDataTable> {
  late CategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of(context);
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
              label: Text(widget.id),
            ),
            DataColumn(
              label: Text(widget.name),
            ),
            const DataColumn(
              label: Text('Actions     '),
              numeric: true,
            ),
          ],
          source: _DataSource(widget.listCategories, categoryBloc, context),
          rowsPerPage: 5, // Change this to set the number of rows per page.
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Category> listCategories;
  final CategoryBloc categoryBloc;
  final BuildContext context;

  _DataSource(this.listCategories, this.categoryBloc, this.context);

  @override
  DataRow getRow(int index) {
    final item = listCategories[index];
    return DataRow(
      cells: [
        DataCell(SelectableText(item.id)),
        DataCell(Text(item.name)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return FormEditCategory(category: item);
                    },
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                              categoryBloc.add(DeleteCategory(item.id));
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
                icon: const Icon(Icons.delete),
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
