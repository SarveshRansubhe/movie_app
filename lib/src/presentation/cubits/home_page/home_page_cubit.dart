import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';
import 'package:movie_app/src/domain/usecases/get_movies_list.dart';

part 'home_page_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> with HydratedMixin {
  final GetMoviesList _getMoviesList;

  final _pageSize = 20;

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  List<Movie> visitedMovies = [];

  HomeCubit(this._getMoviesList) : super(HomeInitial()) {
    hydrate();
  }

  void initialize() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchMovies(pageKey);
    });

    emit(HomeLoaded(_pagingController));
  }

  Future<void> _fetchMovies(int pageKey) async {
    log(pageKey.toString(), name: "_fetchMovies called");
    final response = await _getMoviesList(GetMoviesListParams(page: pageKey));
    response.fold(
      (l) {
        _pagingController.error = l;
      },
      (r) {
        final isLastPage = r.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(r);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(r, nextPageKey);
        }
      },
    );
  }

  void markAsVisited(Movie movie) {
    if (!visitedMovies.any((visited) => visited.id == movie.id)) {
      log('markAsVisited: ${movie.title}');
      visitedMovies.add(movie);
      emit(HomeVisitedUpdated(visitedMovies));
      emit(HomeLoaded(_pagingController));
    } else {
      log('already present');
    }
  }

  // List<Movie> get visitedMovies => visitedMovies;

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final visitedMoviesJson = json['visitedMovies'] as List<dynamic>?;
      visitedMovies = visitedMoviesJson != null
          ? visitedMoviesJson.map((e) => Movie.fromJson(e)).toList()
          : [];
      return HomeLoaded(_pagingController);
    } catch (e) {
      log('Error restoring state: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return {
      'visitedMovies': visitedMovies.map((movie) => movie.toJson()).toList(),
    };
  }

  void removeFromVisited(Movie movie) {
    final isRemoved = visitedMovies.remove(movie);
    log(
      isRemoved.toString(),
      name: "removeFromVisited: ${movie.title} Left: ${visitedMovies.length}",
    );
    emit(HomeVisitedUpdated(visitedMovies));
    emit(HomeLoaded(_pagingController));
  }
}
