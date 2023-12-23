import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/models.dart';
import 'package:e_book_admin/repository/repositories.dart';
part 'view_event.dart';
part 'view_state.dart';
class ViewBloc extends Bloc<ViewEvent, ViewState> {
  final BookRepository _bookRepository;
  ViewBloc({required BookRepository bookRepository})
      : _bookRepository = bookRepository, super(ViewLoading()){
    on<LoadView>(_onLoadView);
    on<UpdateView>(_onUpdateView);
  }
  void _onLoadView(event, Emitter emit) async {
    List<ViewModel>? data = await _bookRepository.getViewBooks();
    add(UpdateView(data!));
  }
  void _onUpdateView(event, Emitter emit) async {
    emit(ViewLoaded(views: event.views));
  }
}