import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/app_errors.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';
import 'package:movie_app/src/domain/usecases/get_movies_list.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomeState> {
  final GetMoviesList _getMoviesList;
  HomePageCubit(this._getMoviesList) : super(HomeInitial());

  Future<void> getPlacemarkFromLatlng() async {
    emit(HomeLoading());
    final response = await _getMoviesList(GetMoviesListParams(page: 1));
    response.fold(
      (l) => emit(HomeError(l)),
      (r) => emit(HomeLoaded(r)),
    );
  }
}
