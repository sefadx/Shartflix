import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_state.g.dart';

abstract class HomeState extends Equatable {
  final List<Movie> listMovie = [];
  HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}

@JsonSerializable()
class HomeNext extends HomeState {
  final List<Movie> movies;
  final Pagination pagination;

  HomeNext({required this.movies, required this.pagination}) {
    super.listMovie.addAll(movies);
  }

  factory HomeNext.fromJson(Map<String, dynamic> json) => _$HomeNextFromJson(json);
  Map<String, dynamic> toJson() => _$HomeNextToJson(this);

  @override
  List<Object?> get props => [movies, pagination];
}

@JsonSerializable()
class Movie extends Equatable {
  final String id;
  final String Title;
  final String Year;
  final String Rated;
  final String Released;
  final String Runtime;
  final String Genre;
  final String Director;
  final String Writer;
  final String Actors;
  final String Plot;
  final String Language;
  final String Country;
  final String Awards;
  final String Poster;
  final String Metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String Type;
  final String Response;
  final List<String> Images;
  final bool ComingSoon;
  final bool isFavorite;

  const Movie({
    required this.id,
    required this.Title,
    required this.Year,
    required this.Rated,
    required this.Released,
    required this.Runtime,
    required this.Genre,
    required this.Director,
    required this.Writer,
    required this.Actors,
    required this.Plot,
    required this.Language,
    required this.Country,
    required this.Awards,
    required this.Poster,
    required this.Metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.Type,
    required this.Response,
    required this.Images,
    required this.ComingSoon,
    required this.isFavorite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class Pagination extends Equatable {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  const Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);

  @override
  List<Object?> get props => [totalCount, perPage, maxPage, currentPage];
}
