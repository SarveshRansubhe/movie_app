import 'package:dartz/dartz.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/app_errors.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';

abstract class AccountRepository {
  Future<Either<AppError, List<Movie>>> getMoviesList(
      GetMoviesListParams params);
}
