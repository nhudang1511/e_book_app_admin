part of 'book_bloc.dart';

abstract class BookEvent  {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class LoadBooks extends BookEvent {
  final int? currentPage;

  const LoadBooks({
    this.currentPage = 1,
  });

  LoadBooks copyWith({
    int? currentPage,
  }) {
    return LoadBooks(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [];
}

class UpdateBook extends BookEvent {
  final List<BookItem> books;
  final int totalBook;

  const UpdateBook(
    this.books,
    this.totalBook,
  );

  @override
  List<Object?> get props => [
        books,
        totalBook,
      ];
}

class AddBook extends BookEvent {
  final String authodId;
  final List<String> categoryId;
  final String description;
  final PlatformFile imageUrl;
  final String language;
  final String title;
  final List<PlatformFile> bookPreview;
  final int chapters;
  final String country;

  const AddBook(this.authodId, this.categoryId, this.description, this.imageUrl,
      this.language, this.title, this.bookPreview, this.chapters, this.country);

  @override
  List<Object?> get props => [
        authodId,
        categoryId,
        description,
        imageUrl,
        language,
        title,
        bookPreview,
        chapters,
        country
      ];
}

class DeleteBook extends BookEvent {
  final String bookId;

  const DeleteBook(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class RemoveBook extends BookEvent {
  final String bookId;

  const RemoveBook(this.bookId);

  @override
  List<Object?> get props => [bookId];
}
