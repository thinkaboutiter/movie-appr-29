import 'package:flutter/material.dart';

class MovieGenresWidget extends StatelessWidget {
  final List<String> genres;
  final double fontSize;

  const MovieGenresWidget({
    super.key,
    required this.genres,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
          ),
          child: Text(
            genre,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.blue[700],
            ),
          ),
        );
      }).toList(),
    );
  }
}
