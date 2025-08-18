// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeNext _$HomeNextFromJson(Map<String, dynamic> json) => HomeNext(
  movies:
      (json['movies'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HomeNextToJson(HomeNext instance) => <String, dynamic>{
  'movies': instance.movies,
  'pagination': instance.pagination,
};

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  id: json['id'] as String,
  Title: json['Title'] as String,
  Year: json['Year'] as String,
  Rated: json['Rated'] as String,
  Released: json['Released'] as String,
  Runtime: json['Runtime'] as String,
  Genre: json['Genre'] as String,
  Director: json['Director'] as String,
  Writer: json['Writer'] as String,
  Actors: json['Actors'] as String,
  Plot: json['Plot'] as String,
  Language: json['Language'] as String,
  Country: json['Country'] as String,
  Awards: json['Awards'] as String,
  Poster: json['Poster'] as String,
  Metascore: json['Metascore'] as String,
  imdbRating: json['imdbRating'] as String,
  imdbVotes: json['imdbVotes'] as String,
  imdbID: json['imdbID'] as String,
  Type: json['Type'] as String,
  Response: json['Response'] as String,
  Images: (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
  ComingSoon: json['ComingSoon'] as bool,
  isFavorite: json['isFavorite'] as bool,
);

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
  'id': instance.id,
  'Title': instance.Title,
  'Year': instance.Year,
  'Rated': instance.Rated,
  'Released': instance.Released,
  'Runtime': instance.Runtime,
  'Genre': instance.Genre,
  'Director': instance.Director,
  'Writer': instance.Writer,
  'Actors': instance.Actors,
  'Plot': instance.Plot,
  'Language': instance.Language,
  'Country': instance.Country,
  'Awards': instance.Awards,
  'Poster': instance.Poster,
  'Metascore': instance.Metascore,
  'imdbRating': instance.imdbRating,
  'imdbVotes': instance.imdbVotes,
  'imdbID': instance.imdbID,
  'Type': instance.Type,
  'Response': instance.Response,
  'Images': instance.Images,
  'ComingSoon': instance.ComingSoon,
  'isFavorite': instance.isFavorite,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  totalCount: (json['totalCount'] as num).toInt(),
  perPage: (json['perPage'] as num).toInt(),
  maxPage: (json['maxPage'] as num).toInt(),
  currentPage: (json['currentPage'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'perPage': instance.perPage,
      'maxPage': instance.maxPage,
      'currentPage': instance.currentPage,
    };
