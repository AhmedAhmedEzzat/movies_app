// movie_card.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double width;
  final VoidCallback? onTap;

  const MovieCard({
    Key? key,
    required this.movie,
    required this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: movie.mediumCover.isNotEmpty
                ? Image.network(
              movie.mediumCover,
              fit: BoxFit.cover,
              loadingBuilder: (ctx, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(color: Colors.grey[900]);
              },
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[850]),
            )
                : Container(color: Colors.grey[850]),
          ),
        ),
      ),
    );
  }
}
