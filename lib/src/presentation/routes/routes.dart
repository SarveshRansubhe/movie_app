import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/app_key.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/di/get_it.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/routes/route_names.dart';
import 'package:movie_app/src/presentation/screen/home/home_screen.dart';
import 'package:movie_app/src/presentation/screen/movie_detail/movie_detail_screen.dart';
import 'package:movie_app/src/presentation/screen/visited_movies_page.dart';

// GoRouter configuration
class RouteGenerator {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.initial,
        redirect: (context, state) => Routes.home,
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<HomeCubit>()..initialize(),
            child: const HomeScreen(),
          );
        },
        routes: [
          GoRoute(
            path: Routes.localMovies,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => getIt<HomeCubit>(),
                child: VisitedMoviesPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.movieDetail,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: state.extra.runtimeType == Movie
                ? MovieDetailsScreen(
                    movie: state.extra as Movie,
                  )
                : null,
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Material(
        child: Center(
          child: Text('No route defined for ${state.uri.toString()}'),
        ),
      );
    },
  );
}
