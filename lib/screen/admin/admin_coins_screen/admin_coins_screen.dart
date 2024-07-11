import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/screen/admin/admin_missions_screen/component/mission_data_table.dart';
import 'package:e_book_admin/screen/admin/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AdminCoinsScreen extends StatefulWidget {
  const AdminCoinsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminCoinsScreenState();

}

class _AdminCoinsScreenState extends State<AdminCoinsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionBloc, MissionState>(builder: (context, state) {
      if (state is MissionLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is MissionLoaded) {
        return SafeArea(
          child: Drawer(
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Header(
                    title: 'Sales',
                  ),
                  MissionDataTable(
                    id: 'Mission ID',
                    name: 'Mission Name',
                    type: 'Type',
                    listMission: (state.missions
                        .toList()
                      ..sort((a, b) => a.name.compareTo(b.name))),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Text("Something went wrong");
      }
    });
  }

}