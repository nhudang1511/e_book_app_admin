
import 'package:bloc/bloc.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import '../../model/models.dart';
part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final AuthorRepository _authorRepository;

  AuthorBloc({required AuthorRepository authorRepository})
      : _authorRepository = authorRepository,
        super(AuthorLoading()){
    on<LoadAuthors>(_onLoadAuthor);
    on<UpdateAuthor>(_onUpdateAuthor);
  }
  void _onLoadAuthor(event, Emitter<AuthorState> emit) async{
    List<Author>? data = await _authorRepository.getAllAuthor();
    add(UpdateAuthor(data!));

  }
  void _onUpdateAuthor(event, Emitter<AuthorState> emit) async{
    emit(AuthorLoaded(authors: event.authors));
  }
}
