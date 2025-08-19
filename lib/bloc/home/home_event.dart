import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_event.g.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class HomeMovieFetched extends HomeEvent {
  final int page;
  const HomeMovieFetched({this.page = 1});

  factory HomeMovieFetched.fromJson(Map<String, dynamic> json) => _$HomeMovieFetchedFromJson(json);
  Map<String, dynamic> toJson() => _$HomeMovieFetchedToJson(this);

  @override
  List<Object?> get props => [page];
}

@JsonSerializable()
class HomeMovieFavoriteRequest extends HomeEvent {
  final String favoriteId;
  const HomeMovieFavoriteRequest({required this.favoriteId});

  factory HomeMovieFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$HomeMovieFavoriteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$HomeMovieFavoriteRequestToJson(this);
}
