import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_book_admin/repository/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:e_book_admin/model/models.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AdminRepository _adminRepository;

  AuthBloc({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(AuthInitial()) {
    on<AuthEventStarted>(_onAuthEventStarted);
    on<AuthEventChanged>(_onAuthEventChanged);
    on<AuthEventLoggedOut>(_onAuthEventLoggedOut);
  }

  void _onAuthEventStarted(
      AuthEventStarted event, Emitter<AuthState> emit) async {
    final Admin? authUser = await _adminRepository.getProfile();
    if (authUser != null) {
      add(AuthEventChanged(authUser));
    } else {
      add(const AuthEventChanged(null));
    }
  }

  void _onAuthEventChanged(
      AuthEventChanged event, Emitter<AuthState> emit) async {
    if (event.authUser != null) {
      emit(AuthenticateState(authUser: event.authUser));
    } else {
      emit(UnAuthenticateState());
    }
  }

  void _onAuthEventLoggedOut(
      AuthEventLoggedOut event, Emitter<AuthState> emit) async {
    unawaited(_adminRepository.signOut());
  }
}
