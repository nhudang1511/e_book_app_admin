import 'package:e_book_admin/blocs/blocs.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:e_book_admin/screen/admin/admin_missions_screen/component/form_add_mission.dart';
import 'package:e_book_admin/screen/admin/admin_missions_screen/component/mission_data_table.dart';
import 'package:e_book_admin/screen/admin/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMissionsScreen extends StatefulWidget {
  const AdminMissionsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AdminMissionsScreenState();
}

class _AdminMissionsScreenState extends State<AdminMissionsScreen> {
  late String? newMission;
  final NotificationRepository _notificationRepository = NotificationRepository();

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
                    title: 'Missions',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30, top: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            newMission = await showDialog<String>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return const FormAddMission();
                              },
                            );
                            if (newMission != null) {
                              _notificationRepository.sendNotificationAll("You have a new mission", "Complete the mission to receive rewards");
                            }
                          },
                          child: const Text("New Mission"),
                        ),
                      ),
                    ],
                  ),
                  MissionDataTable(
                    id: 'Mission ID',
                    name: 'Mission Name',
                    type: 'Type',
                    listMission: state.missions.toList(),
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
