import 'package:flutter/material.dart';

class MovieRatingWidget extends StatelessWidget {
  final double rating;
  final bool showText;
  final double size;

  const MovieRatingWidget({
    super.key,
    required this.rating,
    this.showText = true,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: size),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(fontSize: size * 0.9, fontWeight: FontWeight.bold),
        ),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            '/10',
            style: TextStyle(fontSize: size * 0.8, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }
}
