import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/routes/route_names.dart';
import 'package:movie_app/src/presentation/screen/cached_image.dart';

Widget buildMovieCard(BuildContext context, Movie movie) {
  return Bounceable(
    onTap: () {
      context.read<HomeCubit>().markAsVisited(movie);
      context.push(Routes.movieDetail, extra: movie);
    },
    child: Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            movie.posterPath != null
                ? Hero(
                    tag: "image${movie.id}",
                    child: CachedImage(
                      url: movie.posterPath,
                      isBig: false,
                    ),
                  )
                : Container(
                    width: 80,
                    height: 120,
                    color: Colors.grey,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
            const SizedBox(width: 10),
            // Movie Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? "Unknown Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    movie.releaseDate ?? "Release date not available",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    movie.overview ?? "No overview available",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        '${movie.voteAverage ?? 0}/10',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
