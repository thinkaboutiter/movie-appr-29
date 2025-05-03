import 'package:flutter/material.dart';
import 'package:movie_29/data/repositories/user_repository.dart';
import '../../data/repositories/movies_repository.dart';
import '../../domain/entities/movie_app_e.dart';
import '../widgets/movie_actors_widget.dart';
import '../widgets/movie_genres_widget.dart';
import '../widgets/movie_poster_widget.dart';
import '../widgets/movie_rating_widget.dart';
import '../widgets/movie_title_widget.dart';
import '../../utils/watchlist_support.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieAppE movie;
  final MoviesRepository moviesRepository;
  final UserRepository userRepository;
  late final WatchlistSupport watchlistSupport;
  final VoidCallback? onFavoriteTap;

  MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.moviesRepository,
    required this.userRepository,
    this.onFavoriteTap,
  }) : watchlistSupport = WatchlistSupport(
         moviesRepository: moviesRepository,
         userRepository: userRepository,
       );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          FutureBuilder<bool>(
            future: watchlistSupport.isMovieInWatchlist(movie),
            builder: (context, snapshot) {
              final isInWatchlist = snapshot.data ?? false;
              return IconButton(
                icon: Icon(
                  isInWatchlist ? Icons.favorite : Icons.favorite_border,
                  color: isInWatchlist ? Colors.red : null,
                ),
                onPressed: onFavoriteTap,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section with poster and basic info
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  // Backdrop (blurred poster)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(movie.posterUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.5),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Poster and info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Poster
                        MoviePosterWidget(
                          posterUrl: movie.posterUrl,
                          height: 220,
                          width: 150,
                        ),
                        const SizedBox(width: 16),
                        // Basic info
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MovieTitleWidget(
                                title: movie.title,
                                year: movie.year,
                                isLarge: true,
                              ),
                              const SizedBox(height: 8),
                              MovieRatingWidget(rating: movie.rating, size: 20),
                              const SizedBox(height: 8),
                              if (movie.duration.isNotEmpty)
                                Text(
                                  movie.duration,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Genres
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Genres',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  MovieGenresWidget(genres: movie.genres, fontSize: 14),
                  const SizedBox(height: 24),
                  // Storyline
                  const Text(
                    'Storyline',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.storyline,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  // Cast
                  MovieActorsWidget(actors: movie.actors),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
