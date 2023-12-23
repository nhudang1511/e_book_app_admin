part of 'view_bloc.dart';
abstract class ViewState extends Equatable{
  const ViewState();

  @override
  List<Object?> get props => [];
}
class ViewLoading extends ViewState{
  @override
  List<Object?> get props => [];
}
class ViewLoaded extends ViewState{
  final List<ViewModel> views;
  const ViewLoaded({this.views = const <ViewModel>[]});
  @override
  List<Object?> get props => [views];
}