import 'package:flutter/foundation.dart';
import 'package:movie_29/data/repositories/movies_repository.dart';
import 'package:movie_29/data/repositories/user_repository.dart';
import 'package:movie_29/domain/entities/movie_app_e.dart';

class WatchListSupport {
  final MoviesRepository moviesRepository;
  final UserRepository userRepository;

  WatchListSupport({
    required this.moviesRepository,
    required this.userRepository,
  });

  Future<void> addToWatchlist(MovieAppE movie) async {
    try {
      final user = await userRepository.fetchUser();
      if (user == null) {
        throw Exception('User not found');
      }
      final newUser = user.addToWatchlist(movie.id);
      await userRepository.saveUser(newUser);
    } catch (e) {
      debugPrint('Error adding to watchlist: $e');
    }
  }
}
