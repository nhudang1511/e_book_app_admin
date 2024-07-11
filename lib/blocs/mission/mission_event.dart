part of 'mission_bloc.dart';

abstract class MissionEvent extends Equatable {
  const MissionEvent();

  @override
  List<Object?> get props => [];
}

class LoadMissions extends MissionEvent {
  @override
  List<Object?> get props => [];
}

class AddMission extends MissionEvent {
  final String name;
  final String detail;
  final String type;
  final int coins;
  final int times;

  const AddMission(
    this.name,
    this.detail,
    this.type,
    this.coins,
    this.times,
  );

  @override
  List<Object?> get props => [];
}

class EditMission extends MissionEvent {
  final String id;
  final String name;
  final String detail;
  final String type;
  final int coins;
  final int times;

  const EditMission(
    this.id,
    this.name,
    this.detail,
    this.type,
    this.coins,
    this.times,
  );

  @override
  List<Object?> get props => [];
}
class DeleteMission extends MissionEvent {
  final String missionId;

  const DeleteMission(this.missionId);

  @override
  List<Object?> get props => [];
}
class UpdateMission extends MissionEvent {
  final List<Mission> missions;

  const UpdateMission(this.missions);

  @override
  List<Object?> get props => [missions];
}
