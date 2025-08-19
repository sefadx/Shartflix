// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => HomeState(
  listMovie:
      (json['movies'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pagination:
      json['pagination'] == null
          ? Pagination.initial
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
  'movies': instance.listMovie,
  'pagination': instance.pagination,
};

HomeNext _$HomeNextFromJson(Map<String, dynamic> json) => HomeNext(
  listMovie:
      (json['movies'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeNextToJson(HomeNext instance) => <String, dynamic>{
  'movies': instance.listMovie,
  'pagination': instance.pagination,
};
