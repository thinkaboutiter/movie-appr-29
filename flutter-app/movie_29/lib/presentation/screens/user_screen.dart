import 'package:flutter/material.dart';
import 'package:movie_29/data/repositories/user_repository.dart';
import '../../data/repositories/movies_repository.dart';
import '../../domain/entities/movie_app_e.dart';
import '../../domain/entities/user_app_e.dart';
import '../widgets/user_avatar_widget.dart';
import '../widgets/user_name_widget.dart';
import '../widgets/user_watchlist_widget.dart';
import 'movie_details_screen.dart';
import 'package:flutter/foundation.dart';

class UserScreen extends StatefulWidget {
  final UserRepository userRepository;
  final MoviesRepository moviesRepository;

  const UserScreen({
    super.key,
    required this.userRepository,
    required this.moviesRepository,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserAppE? _user;
  List<MovieAppE> _watchlistMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get user from local storage
      final user = await widget.userRepository.fetchUser();

      // Create default user if none exists
      if (user == null) {
        final defaultUser = UserAppE(
          id: '1',
          name: 'Movie Fan',
          watchlistIds: [],
        );
        await widget.userRepository.saveUser(defaultUser);
        setState(() {
          _user = defaultUser;
        });
      } else {
        setState(() {
          _user = user;
        });
      }

      // Get watchlist movies
      await _loadWatchlistMovies();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading user data: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadWatchlistMovies() async {
    if (_user == null) {
      debugPrint('User is null, cannot load watchlist');
      return;
    }

    try {
      List<MovieAppE> watchlist = [];

      // Filter movies by watchlist IDs
      for (var movieId in _user!.watchlistIds) {
        try {
          final movie = await widget.moviesRepository.getMovie(movieId);
          if (movie != null) {
            watchlist.add(movie);
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Error loading movie $movieId: $e');
          }
        }
      }

      setState(() {
        _watchlistMovies = watchlist;
      });
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading watchlist: $e');
      }
    }
  }

  Future<void> _removeFromWatchlist(String movieId) async {
    try {
      if (_user == null) {
        debugPrint('User is null, cannot remove from watchlist');
        return;
      }

      // TODO: Presentation layer should not modify domain entities directly - involve data layer!!!
      debugPrint('Implement removing movie $movieId from watchlist');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove from watchlist: $e')),
        );
      } else {
        if (kDebugMode) {
          debugPrint('Error removing from watchlist: $e');
        }
      }
    }
  }

  void _navigateToMovieDetails(MovieAppE movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => MovieDetailsScreen(
              movie: movie,
              moviesRepository: widget.moviesRepository,
              userRepository: widget.userRepository,
            ),
      ),
    ).then((_) => _loadWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_user == null) {
      return const Center(child: Text('Error loading user data'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User profile header
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.blue.withValues(alpha: 0.1),
              child: Row(
                children: [
                  UserAvatarWidget(
                    avatarUrl: _user!.avatarUrl,
                    name: _user!.name,
                    size: 80,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserNameWidget(name: _user!.name, fontSize: 24),
                        const SizedBox(height: 8),
                        Text(
                          '${_user!.watchlistIds.length} movies in watchlist',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Show edit profile dialog
                      showDialog(
                        context: context,
                        builder: (context) => _buildEditProfileDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Watchlist
            UserWatchlistWidget(
              watchlist: _watchlistMovies,
              onMovieTap: _navigateToMovieDetails,
              onRemoveTap: _removeFromWatchlist,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditProfileDialog() {
    final nameController = TextEditingController(text: _user!.name);
    final avatarController = TextEditingController(
      text: _user!.avatarUrl ?? '',
    );

    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: avatarController,
            decoration: const InputDecoration(
              labelText: 'Avatar URL (optional)',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            final updatedUser = _user!.copyWith(
              name: nameController.text.trim(),
              avatarUrl:
                  avatarController.text.trim().isEmpty
                      ? null
                      : avatarController.text.trim(),
            );

            await widget.userRepository.saveUser(updatedUser);

            setState(() {
              _user = updatedUser;
            });

            if (mounted) Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
