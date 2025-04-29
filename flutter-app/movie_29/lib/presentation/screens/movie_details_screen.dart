import 'package:flutter/material.dart';
import '../../data/repositories/movies_repository.dart';
import '../../domain/entities/movie_app_e.dart';
import '../widgets/movie_actors_widget.dart';
import '../widgets/movie_genres_widget.dart';
import '../widgets/movie_poster_widget.dart';
import '../widgets/movie_rating_widget.dart';
import '../widgets/movie_title_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieAppE movie;
  final MoviesRepository repository;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            icon: Icon(
              movie.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: movie.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              repository.toggleFavorite(movie.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    movie.isFavorite
                        ? 'Removed from favorites'
                        : 'Added to favorites',
                  ),
                  duration: const Duration(seconds: 1),
                ),
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
                              MovieRatingWidget(
                                rating: movie.rating,
                                size: 20,
                              ),
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MovieGenresWidget(
                    genres: movie.genres,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 24),
                  // Storyline
                  const Text(
                    'Storyline',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.storyline,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
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
