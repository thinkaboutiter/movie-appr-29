import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:movie_29/data/datasources/movies_datasource.dart';
import '../../domain/entities/movie_app_e.dart';

class MoviesRepository {
  final MoviesDatasource _datasource;

  // Cache for movies
  final List<MovieAppE> _moviesCache = [];

  // Controller for movie updates
  final _moviesController = StreamController<List<MovieAppE>>.broadcast();

  // Stream of movies
  Stream<List<MovieAppE>> get movies => _moviesController.stream;

  MoviesRepository({required MoviesDatasource datasource})
    : _datasource = datasource;

  // Initialize repository with stub data
  Future<void> init() async {
    if (_moviesCache.isEmpty) {
      try {
        final movies = await _datasource.getMovies();
        _moviesCache.addAll(movies);
        _moviesController.add(_moviesCache);
      } catch (e) {
        debugPrint('Error loading stub movies: $e');
      }
    }
  }

  // Fetch latest movies from network
  Future<List<MovieAppE>> fetchMovies() async {
    try {
      final movies = await _datasource.getMovies();
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
