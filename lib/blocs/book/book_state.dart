part of 'book_bloc.dart';
abstract class BookState extends Equatable{

  const BookState();
  @override
  List<Object?> get props => [];
}

class BookLoading extends BookState{
  @override
  List<Object?> get props => [];
}
class BookLoaded extends BookState{
  final List<Book> books;

  const BookLoaded({this.books = const <Book>[]});
  @override
  List<Object?> get props => [books];
}
class BookAdded extends BookState {
  final Book book;

  const BookAdded({required this.book});
  @override
  List<Object?> get props => [book];
}