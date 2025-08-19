import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_event.g.dart';

abstract class ProfileEvent extends Equatable {}

@JsonSerializable()
class ProfileFetched extends ProfileEvent {
  final String? userId;
  final String? username;
  ProfileFetched({this.userId, this.username});
  @override
  List<Object?> get props => [];
}
