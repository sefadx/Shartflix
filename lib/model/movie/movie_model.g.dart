// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
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

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
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
