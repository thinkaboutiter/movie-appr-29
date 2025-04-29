import 'package:flutter/material.dart';

class MovieActorsWidget extends StatelessWidget {
  final List<String> actors;

  const MovieActorsWidget({super.key, required this.actors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cast',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              actors.map((actor) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(actor, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
