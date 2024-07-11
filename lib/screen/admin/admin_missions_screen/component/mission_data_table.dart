import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_missions_screen/component/form_detail_mission.dart';
import 'package:e_book_admin/screen/admin/admin_missions_screen/component/form_edit_mission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/models.dart';

class MissionDataTable extends StatefulWidget {
  final String id, name, type;
  final List<Mission> listMission;

  const MissionDataTable({
    super.key,
    required this.id,
    required this.name,
    required this.listMission,
    required this.type,
  });

  @override
  State<StatefulWidget> createState() => _MissionDataTableState();
}

class _MissionDataTableState extends State<MissionDataTable> {
  late MissionBloc missionBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    missionBloc = BlocProvider.of(context);
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
            DataColumn(
              label: Text(widget.type),
            ),
            const DataColumn(
              label: Text('Actions     '),
              numeric: true,
            ),
          ],
          source: _DataSource(widget.listMission, context, missionBloc),
          rowsPerPage: 5,
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Mission> listMissions;
  final BuildContext context;
  final MissionBloc missionBloc;

  _DataSource(this.listMissions, this.context, this.missionBloc);

  @override
  DataRow getRow(int index) {
    final item = listMissions[index];
    return DataRow(
      cells: [
        DataCell(SelectableText(item.id)),
        DataCell(Text(item.name)),
        DataCell(Text(item.type)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MissionDetail(
                          mission: item,
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
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return FormEditMission(mission: item);
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
                              missionBloc.add(
                                DeleteMission(item.id),
                              );
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
  int get rowCount => listMissions.length;

  @override
  int get selectedRowCount => 0;
}
