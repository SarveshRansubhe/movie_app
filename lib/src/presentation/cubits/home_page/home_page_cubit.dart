import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/app_errors.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';
import 'package:movie_app/src/domain/usecases/get_movies_list.dart';

part 'home_page_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetMoviesList _getMoviesList;

  final _pageSize = 20;

  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  HomeCubit(this._getMoviesList) : super(HomeInitial());

  void intialize() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchMovies(pageKey);
    });

    emit(HomeLoaded(_pagingController));
  }

  Future<void> _fetchMovies(int pageKey) async {
    // emit(HomeLoading());
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
        // emit(HomeLoaded(r));
      },
    );
  }
}
