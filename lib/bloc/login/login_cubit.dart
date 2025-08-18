import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    //final bool isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
    emit(state.copyWith(email: value, isEmailValid: true));
  }

  void passwordChanged(String value) {
    //final bool isValid = value.length >= 6;
    emit(state.copyWith(password: value, isPasswordValid: true));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void resetFromStatus() {
    emit(state.copyWith());
  }

  void submit() {
    if (!state.isFormValid) {
      emit(state.copyWith(status: FormStatus.validating));
    } else {
      emit(state.copyWith(status: FormStatus.success));
    }
  }
}
