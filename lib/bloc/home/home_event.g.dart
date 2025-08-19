// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMovieFetched _$HomeMovieFetchedFromJson(Map<String, dynamic> json) =>
    HomeMovieFetched(page: (json['page'] as num?)?.toInt() ?? 1);

Map<String, dynamic> _$HomeMovieFetchedToJson(HomeMovieFetched instance) =>
    <String, dynamic>{'page': instance.page};

HomeMovieFavoriteRequest _$HomeMovieFavoriteRequestFromJson(
  Map<String, dynamic> json,
) => HomeMovieFavoriteRequest(favoriteId: json['favoriteId'] as String);

Map<String, dynamic> _$HomeMovieFavoriteRequestToJson(
  HomeMovieFavoriteRequest instance,
) => <String, dynamic>{'favoriteId': instance.favoriteId};
