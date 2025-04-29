import 'package:flutter/material.dart';
import '../../domain/entities/movie_app_e.dart';
import 'movie_card_row.dart';

class UserWatchlistWidget extends StatelessWidget {
  final List<MovieAppE> watchlist;
  final Function(MovieAppE) onMovieTap;
  final Function(String) onRemoveTap;

  const UserWatchlistWidget({
    super.key,
    required this.watchlist,
    required this.onMovieTap,
    required this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    if (watchlist.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Your watchlist is empty.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Text(
            'My Watchlist',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            final movie = watchlist[index];
            return Dismissible(
              key: Key(movie.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => onRemoveTap(movie.id),
              child: MovieCardRow(movie: movie, onTap: () => onMovieTap(movie)),
            );
          },
        ),
      ],
    );
  }
}
