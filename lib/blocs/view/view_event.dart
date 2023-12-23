part of 'view_bloc.dart';
abstract class ViewEvent {
  const ViewEvent();

  @override
  List<Object?> get props => [];
}

class LoadView extends ViewEvent{
  @override
  List<Object?> get props => [];
}
class UpdateView extends ViewEvent{
  final List<ViewModel> views;
  const UpdateView(this.views);
  @override
  List<Object?> get props => [];
}