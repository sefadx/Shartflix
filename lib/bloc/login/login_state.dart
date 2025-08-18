part of 'login_cubit.dart';

enum FormStatus { initial, validating, success }

class LoginState extends Equatable {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;
  final bool isPasswordVisible;
  final FormStatus status;

  const LoginState({
    this.email = '',
    this.isEmailValid = false,
    this.password = '',
    this.isPasswordValid = false,
    this.isPasswordVisible = false,
    this.status = FormStatus.initial,
  });

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState copyWith({
    String? email,
    bool? isEmailValid,
    String? password,
    bool? isPasswordValid,
    bool? isPasswordVisible,
    FormStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? FormStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
    email,
    isEmailValid,
    password,
    isPasswordValid,
    isPasswordVisible,
    status,
  ];
}
