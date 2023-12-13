part of 'user_bloc.dart';
abstract class UserEvent {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent{
  @override
  List<Object?> get props => [];
}
class UpdateUser extends UserEvent{
  final List<User> users;
  const UpdateUser(this.users);
  @override
  List<Object?> get props => [];
}