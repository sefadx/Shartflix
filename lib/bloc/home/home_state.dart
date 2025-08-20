import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../model/movie/movie_model.dart';
import '../../model/pagination/pagination_model.dart';

part 'home_state.g.dart';

@JsonSerializable()
class HomeState extends Equatable {
  @JsonKey(name: 'movies')
  final List<MovieModel> listMovie;
  final Pagination pagination;
  const HomeState({this.listMovie = const [], this.pagination = Pagination.initial});

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  const HomeLoading({super.listMovie, super.pagination});
}

class HomeFailure extends HomeState {
  final String message;
  const HomeFailure(this.message, {super.listMovie, super.pagination});
}

@JsonSerializable()
class HomeNext extends HomeState {
  const HomeNext({required super.listMovie, required super.pagination});

  factory HomeNext.fromJson(Map<String, dynamic> json) => _$HomeNextFromJson(json);
  Map<String, dynamic> toJson() => _$HomeNextToJson(this);

  @override
  List<Object?> get props => [listMovie, pagination];
}

class HomeMovieFavorite extends HomeState {
  const HomeMovieFavorite({required super.listMovie, super.pagination});
}
