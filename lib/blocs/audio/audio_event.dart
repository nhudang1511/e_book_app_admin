part of 'audio_bloc.dart';
abstract class AudioEvent extends Equatable{
  const AudioEvent();
  @override
  List<Object?> get props => [];
}

class LoadAudio extends AudioEvent{
  @override
  List<Object?> get props => [];
}

class UpdateAudio extends AudioEvent{
  const UpdateAudio();
  @override
  List<Object?> get props => [];
}
class AddAudio extends AudioEvent {
  final String bookId;
  final Map<String, PlatformFile> listChapter;

  const AddAudio(this.bookId, this.listChapter);
  @override
  List<Object?> get props => [bookId, listChapter];
}