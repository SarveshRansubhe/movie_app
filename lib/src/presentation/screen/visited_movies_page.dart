import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/screen/home/movie_card.dart';

class VisitedMoviesPage extends StatelessWidget {
  const VisitedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visited Movies"),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        // buildWhen: (previous, current) => current is HomeVisitedUpdated,
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          final visitedMovies = HomeCubit.visitedMovies;

          if (visitedMovies.isEmpty) {
            return const Center(
              child: Text(
                "No movies visited yet.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: visitedMovies.length,
            itemBuilder: (context, index) {
              final movie = visitedMovies[index];
              return Dismissible(
                key: Key(movie.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  homeCubit.removeFromVisited(movie);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${movie.title} removed from visited."),
                    ),
                  );
                },
                child: buildMovieCard(context, visitedMovies[index]),
              );
            },
          );
        },
      ),
    );
  }
}
