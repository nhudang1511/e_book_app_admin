
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/models.dart';
part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioRepository _audioRepository;

  AudioBloc({required AudioRepository audioRepository})
      : _audioRepository = audioRepository,
        super(AudioLoading()){
    on<LoadAudio>(_onLoadAudio);
    on<UpdateAudio>(_onUpdateAudio);
    on<AddAudio>(_onAddAudio);
  }
  void _onLoadAudio(event, Emitter<AudioState> emit) async{
    add(const UpdateAudio());

  }
  void _onUpdateAudio(event, Emitter<AudioState> emit) async{
    emit(const AudioLoaded());
  }
  void _onAddAudio(event, Emitter<AudioState> emit) async{
    await _audioRepository.addAudios(event.bookId, event.listChapter);
    add(LoadAudio());
  }
}
