import 'package:flutter/material.dart';

import '../movie/models/movie_model.dart';
import 'image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel movie;
  final double widthBackdrop;
  final double heightBackdrop;
  final double heightPoster;
  final double widthPoster;
  ItemMovieWidget({
    required this.movie,
    required this.widthBackdrop,
    required this.heightBackdrop,
    required this.widthPoster,
    required this.heightPoster,
    super.key,
  });

  @override
  // TODO: implement clipBehavior
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      );
  Widget? get child => Stack(
        children: [
          ImageNetworkWidget(
            imageSrc: "${movie.backdropPath}",
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  imageSrc: "${movie.posterPath}",
                  height: heightPoster,
                  width: widthPoster,
                  radius: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        '${movie.voteAverage} (${movie.voteCount})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
