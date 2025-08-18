// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequested _$LoginRequestedFromJson(Map<String, dynamic> json) =>
    LoginRequested(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestedToJson(LoginRequested instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

RegisterRequested _$RegisterRequestedFromJson(Map<String, dynamic> json) =>
    RegisterRequested(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterRequestedToJson(RegisterRequested instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
