// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePageFetched _$ProfilePageFetchedFromJson(Map<String, dynamic> json) =>
    ProfilePageFetched(userId: json['userId'] as String?);

Map<String, dynamic> _$ProfilePageFetchedToJson(ProfilePageFetched instance) =>
    <String, dynamic>{'userId': instance.userId};

ProfileFetched _$ProfileFetchedFromJson(Map<String, dynamic> json) =>
    ProfileFetched(userId: json['userId'] as String?);

Map<String, dynamic> _$ProfileFetchedToJson(ProfileFetched instance) =>
    <String, dynamic>{'userId': instance.userId};

ProfileFavoriteMovieFetched _$ProfileFavoriteMovieFetchedFromJson(
  Map<String, dynamic> json,
) => ProfileFavoriteMovieFetched(page: (json['page'] as num?)?.toInt() ?? 1);

Map<String, dynamic> _$ProfileFavoriteMovieFetchedToJson(
  ProfileFavoriteMovieFetched instance,
) => <String, dynamic>{'page': instance.page};
