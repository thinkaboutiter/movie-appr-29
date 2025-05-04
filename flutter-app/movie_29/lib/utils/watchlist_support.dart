import 'package:flutter/foundation.dart';
import 'package:movie_29/data/repositories/movies_repository.dart';
import 'package:movie_29/data/repositories/user_repository.dart';
import 'package:movie_29/domain/entities/movie_app_e.dart';

class WatchlistSupport {
  final MoviesRepository moviesRepository;
  final UserRepository userRepository;

  WatchlistSupport({
    required this.moviesRepository,
    required this.userRepository,
  });

  Future<void> updateWatchlistWithMoview(MovieAppE movie) async {
    try {
      final user = await userRepository.fetchUser();
      if (user == null) {
        throw Exception('User not found');
      }

      final isInWatchlist = await isMovieInWatchlist(movie);
      if (isInWatchlist) {
        debugPrint('Removing movie ${movie.id} from watchlist');

        final newUser = user.removeFromWatchlist(movie.id);
        await userRepository.saveUser(newUser);
      } else {
        debugPrint('Adding movie ${movie.id} to watchlist');

        final newUser = user.addToWatchlist(movie.id);
        await userRepository.saveUser(newUser);
      }
    } catch (e) {
      debugPrint('Error adding to watchlist: $e');
    }
  }

  Future<bool> isMovieInWatchlist(MovieAppE movie) async {
    final user = await userRepository.fetchUser();
    if (user == null) {
      return false;
    }
    return user.watchlistIds.contains(movie.id);
  }
}
