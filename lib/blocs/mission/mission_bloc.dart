import 'package:e_book_admin/repository/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '../../model/models.dart';

part 'mission_event.dart';

part 'mission_state.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  final MissionRepository _missionRepository;

  MissionBloc({required MissionRepository missionRepository})
      : _missionRepository = missionRepository,
        super(MissionLoading()) {
    on<LoadMissions>(_onLoadMission);
    on<UpdateMission>(_onUpdateMission);
    on<AddMission>(_onAddMission);
    on<EditMission>(_onEditMission);
    on<DeleteMission>(_onDeleteMission);
  }

  void _onLoadMission(event, Emitter<MissionState> emit) async {
    List<Mission>? data = await _missionRepository.getAllMissions();
    add(UpdateMission(data!));
  }

  void _onAddMission(event, Emitter<MissionState> emit) async {
    await _missionRepository.addMission(
      event.name,
      event.detail,
      event.coins,
      event.type,
      event.times,
    );
    add(LoadMissions());
  }

  void _onEditMission(event, Emitter<MissionState> emit) async {
    await _missionRepository.updateMission(
      event.id,
      event.name,
      event.detail,
      event.coins,
      event.type,
      event.times,
    );
    add(LoadMissions());
  }

  void _onDeleteMission(event, Emitter<MissionState> emit) async {
    await _missionRepository.deleteMission(event.missionId);
    add(LoadMissions());
  }

  void _onUpdateMission(event, Emitter<MissionState> emit) async {
    emit(MissionLoaded(missions: event.missions));
  }
}
