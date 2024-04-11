import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:e_book_admin/repository/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AdminRepository _adminRepository;

  LoginCubit({
    required AdminRepository adminRepository,
  })  : _adminRepository = adminRepository,
        super(LoginState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<void> logIn() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      final credential = await _adminRepository.login(
        state.email,
        state.password,
      );
      emit(
        state.copyWith(email: '', password: ''),
      );
      if (credential == true) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(status: LoginStatus.error));
      }
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
