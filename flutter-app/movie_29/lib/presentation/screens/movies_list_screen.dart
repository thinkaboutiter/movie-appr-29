import 'package:flutter/material.dart';
import '../../data/repositories/movies_repository.dart';
import '../../domain/entities/movie_app_e.dart';
import '../widgets/movie_card_row.dart';
import 'movie_details_screen.dart';

class MoviesListScreen extends StatefulWidget {
  final MoviesRepository repository;

  const MoviesListScreen({
    super.key,
    required this.repository,
  });

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  bool _isLoading = true;
  List<MovieAppE> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      _isLoading = true;
    });

    await widget.repository.init();
    
    // Subscribe to the stream
    widget.repository.movies.listen((movies) {
      if (mounted) {
        setState(() {
          _movies = movies;
          _isLoading = false;
        });
      }
    });
    
    // Refresh movies from network
    try {
      await widget.repository.fetchMovies();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch movies: $e')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _navigateToDetails(MovieAppE movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(
          movie: movie,
          repository: widget.repository,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMovies,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadMovies,
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return MovieCardRow(
                    movie: movie,
                    onTap: () => _navigateToDetails(movie),
                    onFavoriteTap: () {
                      widget.repository.toggleFavorite(movie.id);
                    },
                  );
                },
              ),
            ),
    );
  }
}
