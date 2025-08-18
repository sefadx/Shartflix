import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_event.g.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class HomeFetched extends HomeEvent {
  final int page;
  const HomeFetched({this.page = 1});

  factory HomeFetched.fromJson(Map<String, dynamic> json) => _$HomeFetchedFromJson(json);
  Map<String, dynamic> toJson() => _$HomeFetchedToJson(this);

  @override
  List<Object?> get props => [page];
}
