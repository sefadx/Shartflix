import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String token;
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  const UserModel({required this.token, required this.id, this.name, this.email, this.photoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [token, id, name, email, photoUrl];
}
