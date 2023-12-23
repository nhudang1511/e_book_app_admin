import 'package:bloc/bloc.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import '../../model/models.dart';

part 'book_event.dart';

part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository;

  BookBloc({required BookRepository bookRepository})
      : _bookRepository = bookRepository,
        super(BookLoading()) {
    on<LoadBooks>(_onLoadBook);
    on<UpdateBook>(_onUpdateBook);
    on<AddBook>(_onAddBook);
    on<DeleteBook>(_onDeleteBook);
    on<RemoveBook>(_onRemoveBook);
  }

  void _onLoadBook(event, Emitter<BookState> emit) async {
    List<Book>? data = await _bookRepository.getAllBook();
    add(UpdateBook(data!));
  }

  void _onUpdateBook(event, Emitter<BookState> emit) async {
    emit(BookLoaded(books: event.books));
  }

  void _onAddBook(event, Emitter<BookState> emit) async {
    final Book? newBook = await _bookRepository.addBook(
        event.title,
        event.authodId,
        event.categoryId,
        event.description,
        event.imageUrl,
        event.language,
        event.bookPreview,
        event.chapters,
        event.country);
    if (newBook != null) {
      emit(BookAdded(book: newBook));
    }
    add(LoadBooks());
  }

  void _onDeleteBook(event, Emitter<BookState> emit) async {
    await _bookRepository.deleteBook(event.bookId);
    add(LoadBooks());
  }

  void _onRemoveBook(event, Emitter<BookState> emit) async {
    await _bookRepository.removeBook(event.bookId);
    add(LoadBooks());
  }
}
