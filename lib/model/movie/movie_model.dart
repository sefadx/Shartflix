import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Equatable {
  final String id;
  final String Title;
  final String Year;
  final String Rated;
  final String Released;
  final String Runtime;
  final String Genre;
  final String Director;
  final String Writer;
  final String Actors;
  final String Plot;
  final String Language;
  final String Country;
  final String Awards;
  final String Poster;
  final String Metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String Type;
  final String Response;
  final List<String> Images;
  final bool ComingSoon;
  final bool isFavorite;

  const MovieModel({
    required this.id,
    required this.Title,
    required this.Year,
    required this.Rated,
    required this.Released,
    required this.Runtime,
    required this.Genre,
    required this.Director,
    required this.Writer,
    required this.Actors,
    required this.Plot,
    required this.Language,
    required this.Country,
    required this.Awards,
    required this.Poster,
    required this.Metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.Type,
    required this.Response,
    required this.Images,
    required this.ComingSoon,
    required this.isFavorite,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  String get fixPosterUrl {
    var u = Poster.trim();

    // http -> https
    u = u.replaceFirst(RegExp(r'^http://'), 'https://');

    // ia.media-imdb.com -> m.media-amazon.com  (IMDb görselleri genelde bu CDN'de)
    u = u.replaceFirst(RegExp(r'^https://ia\.media-imdb\.com'), 'https://m.media-amazon.com');

    // '..jpg' -> '._V1_.jpg'  (eksik versiyon eki)
    u = u.replaceFirst(RegExp(r'\.\.jpg$'), '._V1_.jpg');

    // '@@.jpg' veya '@@..jpg' -> '@@._V1_.jpg'
    u = u.replaceFirst(RegExp(r'@@(?:\.)*jpg$'), '@@._V1_.jpg');

    // '@@' içeriyor, '.jpg' ile bitiyor, ama '._V1_' yoksa -> ekle
    if (u.endsWith('.jpg') && u.contains('@@') && !u.contains('._V1_')) {
      u = u.replaceFirst('.jpg', '._V1_.jpg');
    }

    return u;
  }

  @override
  List<Object?> get props => [id];
}
