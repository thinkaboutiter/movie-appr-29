import 'package:flutter/material.dart';

class MoviePosterWidget extends StatelessWidget {
  final String posterUrl;
  final double height;
  final double width;
  final bool isRounded;

  const MoviePosterWidget({
    super.key,
    required this.posterUrl,
    this.height = 150,
    this.width = 100,
    this.isRounded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: isRounded ? BorderRadius.circular(8) : BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: isRounded ? BorderRadius.circular(8) : BorderRadius.zero,
        child: Image.network(
          posterUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
