import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/src/app_key.dart';
import 'package:movie_app/src/di/get_it.dart';
import 'package:movie_app/src/presentation/cubits/home_page/home_page_cubit.dart';
import 'package:movie_app/src/presentation/routes/route_names.dart';
import 'package:movie_app/src/presentation/screen/home/home_screen.dart';

// GoRouter configuration
class RouteGenerator {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.initial,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<HomePageCubit>(),
              ),
            ],
            child: const HomeScreen(),
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
