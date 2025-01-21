import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/routes/route_names.dart';
import 'package:movie_app/src/presentation/screen/home/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              context.push(Routes.home + Routes.localMovies);
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          if (current is HomeVisitedUpdated) {
            return false;
          }
          return previous != current;
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (HomeLoaded):
              return PagedListView<int, Movie>(
                pagingController: (state as HomeLoaded).pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, item, index) => buildMovieCard(
                    context,
                    item,
                  ),
                ),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
