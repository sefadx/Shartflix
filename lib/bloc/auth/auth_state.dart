import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_state.g.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);
  @override
  List<Object?> get props => [error];
}

@JsonSerializable()
class Authenticated extends AuthState {
  final String token;
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  const Authenticated({
    required this.token,
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  factory Authenticated.fromJson(Map<String, dynamic> json) => _$AuthenticatedFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticatedToJson(this);

  @override
  List<Object?> get props => [token, id, name, email, photoUrl];
}

class Unauthenticated extends AuthState {}
