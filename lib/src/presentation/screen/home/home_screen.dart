import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/routes/route_names.dart';
import 'package:movie_app/src/presentation/screen/cached_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            // case const (HomeLoading):
            //   return _buildMovieWidget();
            case const (HomeLoaded):
              return PagedListView<int, Movie>(
                pagingController: (state as HomeLoaded).pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, item, index) =>
                      _buildMovieWidget(item),
                ),
              );
            case const (HomeError):
              return Text((state as HomeError).appError.error.toString());
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildMovieWidget(Movie movie) {
    return Bounceable(
      onTap: () {
        context.push(Routes.movieDetail, extra: movie);
      },
      child: Card(
        margin: EdgeInsets.all(10),
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
                      child: Icon(Icons.image, color: Colors.white),
                    ),
              SizedBox(width: 10),
              // Movie Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      movie.title ?? "Unknown Title",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      movie.releaseDate ?? "Release date not available",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      movie.overview ?? "No overview available",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '${movie.voteAverage ?? 0}/10',
                          style: TextStyle(fontSize: 14),
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
}
