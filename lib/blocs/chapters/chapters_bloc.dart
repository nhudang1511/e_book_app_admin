
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/models.dart';
part 'chapters_event.dart';
part 'chapters_state.dart';

class ChaptersBloc extends Bloc<ChaptersEvent, ChaptersState> {
  final ChaptersRepository _chaptersRepository;

  ChaptersBloc({required ChaptersRepository chaptersRepository})
      : _chaptersRepository = chaptersRepository,
        super(ChaptersLoading()){
    on<LoadChapters>(_onLoadChapters);
    on<UpdateChapters>(_onUpdateChapters);
    on<AddChapters>(_onAddChapters);
  }
  void _onLoadChapters(event, Emitter<ChaptersState> emit) async{
    add(const UpdateChapters());

  }
  void _onUpdateChapters(event, Emitter<ChaptersState> emit) async{
    emit(const ChaptersLoaded());
  }
  void _onAddChapters(event, Emitter<ChaptersState> emit) async{
    await _chaptersRepository.addChapters(event.bookId, event.listChapter);
    add(LoadChapters());
  }
}
