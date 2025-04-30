import 'package:flutter/material.dart';

class MovieTitleWidget extends StatelessWidget {
  final String title;
  final String year;
  final bool isLarge;

  const MovieTitleWidget({
    super.key,
    required this.title,
    required this.year,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isLarge ? 24 : 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          year,
          style: TextStyle(
            fontSize: isLarge ? 16 : 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
