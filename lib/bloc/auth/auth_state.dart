
part of 'auth_bloc.dart';

class AuthState extends Equatable{
  const AuthState();

@override
  List<Object?> get props => [];
}

class Authenticated extends AuthState{
  final String userId;
  final String accessToken;

  const Authenticated({
    required this.userId,
    required this.accessToken });

  @override
  List<Object?> get props => [userId, accessToken];
}

class Unauthenticated extends AuthState{}