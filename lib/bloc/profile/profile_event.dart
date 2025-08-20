import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_event.g.dart';

abstract class ProfileEvent extends Equatable {}

@JsonSerializable()
class ProfilePageFetched extends ProfileEvent {
  final String? userId;
  ProfilePageFetched({this.userId});
  @override
  List<Object?> get props => [userId];
}

@JsonSerializable()
class ProfileFetched extends ProfileEvent {
  final String? userId;
  ProfileFetched({this.userId});
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ProfileFavoriteMovieFetched extends ProfileEvent {
  final int page;
  ProfileFavoriteMovieFetched({this.page = 1});

  factory ProfileFavoriteMovieFetched.fromJson(Map<String, dynamic> json) =>
      _$ProfileFavoriteMovieFetchedFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileFavoriteMovieFetchedToJson(this);

  @override
  List<Object?> get props => [page];
}
