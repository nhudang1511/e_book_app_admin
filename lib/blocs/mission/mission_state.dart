part of 'mission_bloc.dart';

abstract class MissionState extends Equatable {
  const MissionState();

  @override
  List<Object?> get props => [];
}

class MissionLoading extends MissionState {
  @override
  List<Object?> get props => [];
}

class MissionLoaded extends MissionState {
  final List<Mission> missions;

  const MissionLoaded({this.missions = const <Mission>[]});

  @override
  List<Object?> get props => [missions];
}
