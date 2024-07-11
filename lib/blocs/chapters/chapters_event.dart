part of 'chapters_bloc.dart';
abstract class ChaptersEvent extends Equatable{
  const ChaptersEvent();
  @override
  List<Object?> get props => [];
}

class LoadChapters extends ChaptersEvent{
  @override
  List<Object?> get props => [];
}

class UpdateChapters extends ChaptersEvent{
  const UpdateChapters();
  @override
  List<Object?> get props => [];
}
class AddChapters extends ChaptersEvent {
  final String bookId;
  final Map<String, String> listChapter;

  const AddChapters(this.bookId, this.listChapter);
  @override
  List<Object?> get props => [bookId, listChapter];
}