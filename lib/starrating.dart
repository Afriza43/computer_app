import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final Color starColor;
  final double size;
  final int minStars;
  final int maxReviews;

  const StarRating({
    super.key,
    required this.rating,
    this.starColor = Colors.yellow,
    this.size = 24.0,
    this.minStars = 4,
    this.maxReviews = 500,
  });

  @override
  Widget build(BuildContext context) {
    double displayRating = rating < minStars ? minStars.toDouble() : rating;
    int numberOfReviews = Random().nextInt(maxReviews);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${displayRating.toStringAsFixed(1)} ",
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 3),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            double value = index + 1.0;

            // Full star
            if (value <= displayRating) {
              return Icon(
                Icons.star,
                color: const Color(0xffFFBA36),
                size: size,
              );
            }

            // Half star
            if (value - 0.5 <= displayRating) {
              return Icon(
                Icons.star_half,
                color: const Color(0xffFFBA36),
                size: size,
              );
            }

            // Empty star
            return Icon(
              Icons.star_border,
              color: const Color(0xffFFBA36),
              size: size,
            );
          }),
        ),
        const SizedBox(width: 5),
        Text(
          '($numberOfReviews)',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
