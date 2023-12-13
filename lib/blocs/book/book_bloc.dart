
import 'package:bloc/bloc.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import '../../model/models.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository;

  BookBloc({required BookRepository bookRepository})
      : _bookRepository = bookRepository,
        super(BookLoading()){
    on<LoadBooks>(_onLoadBook);
    on<UpdateBook>(_onUpdateBook);
  }
  void _onLoadBook(event, Emitter<BookState> emit) async{
    List<Book>? data = await _bookRepository.getAllBook();
    add(UpdateBook(data!));

  }
  void _onUpdateBook(event, Emitter<BookState> emit) async{
    emit(BookLoaded(books: event.books));
  }
}
