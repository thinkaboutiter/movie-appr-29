import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:movie_29/utils/constants.dart';
import '../../domain/entities/movie_app_e.dart';
import '../../domain/entities/movie_network_e.dart';
import '../datasources/movies_network_datasource_i.dart';
import '../datasources/movies_network_datasource.dart';

class MoviesRepository {
  static MovieAppE movieAppEntityFromNetworkEntity(MovieNetworkE networkMovie) {
    return MovieAppE(
      id: networkMovie.id,
      title: networkMovie.title,
      year: networkMovie.year,
      genres: networkMovie.genres,
      posterUrl: networkMovie.posterUrl,
      rating: networkMovie.rating,
      duration: networkMovie.duration,
      storyline: networkMovie.storyline,
      actors: networkMovie.actors,
    );
  }

  final MoviesNetworkDatasourceI _networkDatasource;

  // Cache for movies
  final List<MovieAppE> _moviesCache = [];

  // Controller for movie updates
  final _moviesController = StreamController<List<MovieAppE>>.broadcast();

  // Stream of movies
  Stream<List<MovieAppE>> get movies => _moviesController.stream;

  MoviesRepository({
    MoviesNetworkDatasourceI? networkDatasource,
  }) : _networkDatasource = networkDatasource ?? MoviesNetworkDataSource();

  // Future<void> init() async {
  //   if (_moviesCache.isEmpty) {
  //     try {
  //       return await fetchMovies()
  //     } catch (e) {
  //       debugPrint('Error loading stub movies: $e');
  //     }
  //   }
  // }

  // Fetch latest movies from network
  Future<List<MovieAppE>> fetchMovies() async {
    try {
      final networkMovies = await _networkDatasource.getMovies();
      final movies =
          networkMovies
              .map(
                (networkMovie) => movieAppEntityFromNetworkEntity(networkMovie),
              )
              .toList();

      debugPrint('Fetched ${movies.length} movies from network');

      _moviesCache.clear();
      _moviesCache.addAll(movies);
      _moviesController.add(_moviesCache);
      return _moviesCache;
    } catch (e) {
      debugPrint('Error fetching movies from network: $e');
      // If network fails, return cache
      return _moviesCache;
    }
  }

  // Get movie by ID
  Future<MovieAppE?> getMovie(String id) async {
    // Check cache first
    final cachedMovie = _moviesCache.firstWhere(
      (movie) => movie.id == id,
      orElse: () => throw Exception('Movie not found in cache'),
    );

    return cachedMovie;
  }

  // Toggle favorite status
  Future<void> toggleFavorite(String id) async {
    final index = _moviesCache.indexWhere((movie) => movie.id == id);

    debugPrint('Toggling favorite for movie with ID: $id, index: $index');

    if (index != -1) {
      final movie = _moviesCache[index];
      _moviesCache[index] = movie.copyWith(isFavorite: !movie.isFavorite);
      _moviesController.add(_moviesCache);
    }
  }

  void dispose() {
    _moviesController.close();
  }
}
