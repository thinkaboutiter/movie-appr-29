import 'package:movie_29/domain/entities/movie.dart';
import 'package:movie_29/domain/entities/movie_network_e.dart';

class MovieAppE implements Movie {
  @override
  final String id;
  @override
  final String title;
  @override
  final String year;
  @override
  final List<String> genres;
  @override
  final String posterUrl;
  @override
  final double rating;
  @override
  final String duration;
  @override
  final String storyline;
  @override
  final List<String> actors;

  MovieAppE({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
    required this.duration,
    required this.storyline,
    required this.actors,
  });

  factory MovieAppE.fromNetworkEntity(MovieNetworkE networkEntity) {
    return MovieAppE(
      id: networkEntity.id,
      title: networkEntity.title,
      year: networkEntity.year,
      genres: networkEntity.genres,
      posterUrl: networkEntity.posterUrl,
      rating: networkEntity.rating,
      duration: networkEntity.duration
          .replaceAll('PT', '')
          .replaceAll('M', ' min'),
      storyline: networkEntity.storyline,
      actors: networkEntity.actors,
    );
  }

  MovieAppE copyWith({
    String? id,
    String? title,
    String? year,
    List<String>? genres,
    String? posterUrl,
    double? rating,
    String? duration,
    String? storyline,
    List<String>? actors,
    bool? isFavorite,
  }) {
    return MovieAppE(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      genres: genres ?? this.genres,
      posterUrl: posterUrl ?? this.posterUrl,
      rating: rating ?? this.rating,
      duration: duration ?? this.duration,
      storyline: storyline ?? this.storyline,
      actors: actors ?? this.actors,
    );
  }
}
