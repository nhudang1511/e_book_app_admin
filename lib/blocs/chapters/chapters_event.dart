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
  final List<Chapters> chapters;
  const UpdateChapters(this.chapters);
  @override
  List<Object?> get props => [chapters];
}
class AddChapters extends ChaptersEvent {
  final String bookId;
  final Map<String, String> listChapter;

  const AddChapters(this.bookId, this.listChapter);
  @override
  List<Object?> get props => [bookId, listChapter];
}