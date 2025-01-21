import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/screen/home/movie_card.dart';

class VisitedMoviesPage extends StatelessWidget {
  const VisitedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final visitedMovies = context.read<HomeCubit>().visitedMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Visited Movies"),
      ),
      body: visitedMovies.isEmpty
          ? const Center(
              child: Text(
                "No movies visited yet.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: visitedMovies.length,
              itemBuilder: (context, index) =>
                  buildMovieCard(context, visitedMovies[index]),
            ),
    );
  }
}
