import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_state.g.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;
  const ProfileFailure(this.message);
}

@JsonSerializable()
class ProfileInformation extends ProfileState {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  const ProfileInformation({required this.id, this.name, this.email, this.photoUrl});

  factory ProfileInformation.fromJson(Map<String, dynamic> json) =>
      _$ProfileInformationFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInformationToJson(this);

  @override
  List<Object?> get props => [id, name, email, photoUrl];
}
