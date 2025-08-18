part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final String name;
  final bool isFullNameValid;
  final String email;
  final bool isEmailValid;
  final String password;
  final String rePassword;
  final bool isPasswordValid;
  final bool checkRePassword;
  final bool isPasswordVisible;
  final bool checkAgreement;
  final FormStatus status;

  const RegisterState({
    this.name = '',
    this.isFullNameValid = false,
    this.email = '',
    this.isEmailValid = false,
    this.password = '',
    this.rePassword = '',
    this.isPasswordValid = false,
    this.checkRePassword = false,
    this.isPasswordVisible = false,
    this.checkAgreement = false,
    this.status = FormStatus.initial,
  });

  bool get isFormValid =>
      isFullNameValid && isEmailValid && isPasswordValid && checkRePassword && checkAgreement;

  RegisterState copyWith({
    String? name,
    bool? isFullNameValid,
    String? email,
    bool? isEmailValid,
    String? password,
    String? rePassword,
    bool? isPasswordValid,
    bool? checkRePassword,
    bool? isPasswordVisible,
    bool? checkAgreement,
    FormStatus? status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      isFullNameValid: isFullNameValid ?? this.isFullNameValid,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      checkRePassword: checkRePassword ?? this.checkRePassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      checkAgreement: checkAgreement ?? this.checkAgreement,
      status: status ?? FormStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
    name,
    isFullNameValid,
    email,
    isEmailValid,
    password,
    rePassword,
    isPasswordValid,
    checkRePassword,
    isPasswordVisible,
    checkAgreement,
    status,
  ];
}
