import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/models.dart';
import 'package:e_book_admin/repository/repositories.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository, super(UserLoading()){
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
  }
  void _onLoadUser(event, Emitter emit) async {
    List<User>? data = await _userRepository.getAllUser();
    add(UpdateUser(data!));
  }
  void _onUpdateUser(event, Emitter emit) async {
    emit(UserLoaded(users: event.users));
  }
}