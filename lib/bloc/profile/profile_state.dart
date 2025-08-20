part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final UserModel? user;
  final List<MovieModel> listFavoriteMovie;
  const ProfileState({this.listFavoriteMovie = const [], this.user});

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  const ProfileLoading({super.listFavoriteMovie, super.user});
}

class ProfileFailure extends ProfileState {
  final String message;
  const ProfileFailure(this.message, {super.listFavoriteMovie, super.user});
}

class ProfileFavoriteMovieFailure extends ProfileState {
  final String message;
  const ProfileFavoriteMovieFailure(this.message, {super.listFavoriteMovie, super.user});
}

class ProfileInformation extends ProfileState {
  const ProfileInformation({required UserModel user, super.listFavoriteMovie}) : super(user: user);
}

class ProfileFavoriteMovieNext extends ProfileState {
  const ProfileFavoriteMovieNext({super.listFavoriteMovie, super.user});
}
