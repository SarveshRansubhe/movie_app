import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/presentation/screen/cached_image.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w1280${movie.backdropPath}',
              fit: BoxFit.fitWidth,
              progressIndicatorBuilder: (context, url, progress) => FittedBox(
                fit: BoxFit.fitWidth,
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Center(
                    child: movie.posterPath != null
                        ? Hero(
                            tag: "image${movie.id}",
                            child: CachedImage(
                              url: movie.posterPath,
                              isBig: true,
                            ),
                          )
                        : Container(
                            height: 300,
                            width: 200,
                            color: Colors.grey,
                            child: Icon(Icons.image,
                                size: 100, color: Colors.white),
                          ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    movie.title ?? "No Title Available",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Release Date: ${movie.releaseDate ?? "Unknown"}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    movie.overview ?? "No overview available.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  _buildDetailRow("Original Title", movie.originalTitle),
                  _buildDetailRow("Language", movie.originalLanguage),
                  _buildDetailRow("Popularity", movie.popularity?.toString()),
                  _buildDetailRow(
                      "Vote Average", "${movie.voteAverage ?? 0}/10"),
                  _buildDetailRow("Vote Count", movie.voteCount?.toString()),
                ],
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
