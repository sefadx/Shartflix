import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_cubit.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  void fullNameChanged(String value) {
    final bool isValid = value.length >= 4 && value.length < 20;
    emit(state.copyWith(name: value, isFullNameValid: isValid));
  }

  void emailChanged(String value) {
    final bool isValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
    emit(state.copyWith(email: value, isEmailValid: isValid));
  }

  void passwordChanged(String value) {
    final bool isValid = value.length >= 6;
    emit(state.copyWith(password: value, isPasswordValid: isValid));
  }

  void rePasswordChanged(String value) {
    final bool isValid = value.length >= 6;
    emit(state.copyWith(rePassword: value, checkRePassword: isValid));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void checkAgreement() {
    emit(state.copyWith(checkAgreement: true));
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
