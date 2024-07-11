part of 'audio_bloc.dart';
abstract class AudioState extends Equatable{

  const AudioState();
  @override
  List<Object?> get props => [];
}

class AudioLoading extends AudioState{
  @override
  List<Object?> get props => [];
}
class AudioLoaded extends AudioState{
  final List<Audio> audio;

  const AudioLoaded({this.audio = const <Audio>[]});
  @override
  List<Object?> get props => [audio];
}