import 'package:movie_29/domain/entities/movie.dart';

class MovieNetworkE implements Movie {
  @override
  final String id;
  @override
  final String title;
  @override
  final String year;
  @override
  final List<String> genres;
  @override
  final String storyline;
  @override
  final List<String> actors;
  @override
  final String duration;

  final List<int> ratings;
  final String poster;
  final String contentRating;
  final String releaseDate;
  final double averageRating;
  final String originalTitle;
  final dynamic imdbRating;
  final String posterurl;

  MovieNetworkE({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    required this.poster,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.averageRating,
    required this.originalTitle,
    required this.storyline,
    required this.actors,
    required this.imdbRating,
    required this.posterurl,
  });

  factory MovieNetworkE.fromJson(Map<String, dynamic> json) {
    return MovieNetworkE(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      year: json['year'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      ratings: List<int>.from(json['ratings'] ?? []),
      poster: json['poster'] ?? '',
      contentRating: json['contentRating'] ?? '',
      duration: json['duration'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      originalTitle: json['originalTitle'] ?? '',
      storyline: json['storyline'] ?? '',
      actors: List<String>.from(json['actors'] ?? []),
      imdbRating: json['imdbRating'],
      posterurl: json['posterurl'] ?? '',
    );
  }

  @override
  String get posterUrl => posterurl;

  @override
  double get rating {
    if (imdbRating != null && imdbRating is num) {
      return (imdbRating as num).toDouble();
    } else if (ratings.isNotEmpty) {
      return ratings.reduce((a, b) => a + b) / ratings.length;
    }
    return 0.0;
  }
}
