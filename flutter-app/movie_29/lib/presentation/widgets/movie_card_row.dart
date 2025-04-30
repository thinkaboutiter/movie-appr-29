import 'package:flutter/material.dart';
import '../../domain/entities/movie_app_e.dart';
import 'movie_poster_widget.dart';
import 'movie_rating_widget.dart';
import 'movie_title_widget.dart';

class MovieCardRow extends StatelessWidget {
  final MovieAppE movie;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;

  const MovieCardRow({
    super.key,
    required this.movie,
    required this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviePosterWidget(
                posterUrl: movie.posterUrl,
                height: 120,
                width: 80,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MovieTitleWidget(
                            title: movie.title,
                            year: movie.year,
                          ),
                        ),
                        if (onFavoriteTap != null)
                          IconButton(
                            icon: Icon(
                              movie.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: movie.isFavorite ? Colors.red : null,
                            ),
                            onPressed: onFavoriteTap,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    MovieRatingWidget(rating: movie.rating),
                    const SizedBox(height: 8),
                    Text(
                      movie.genres.join(', '),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (movie.duration.isNotEmpty)
                      Text(
                        movie.duration,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
