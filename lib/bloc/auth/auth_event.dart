import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_event.g.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

@JsonSerializable()
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  factory LoginRequested.fromJson(Map<String, dynamic> json) => _$LoginRequestedFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestedToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [email, password];
}

@JsonSerializable()
class RegisterRequested extends AuthEvent {
  final String name, email, password;
  const RegisterRequested({required this.name, required this.email, required this.password});
  factory RegisterRequested.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestedFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestedToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  List<Object?> get props => [name, email, password];
}

class LogoutRequested extends AuthEvent {}
