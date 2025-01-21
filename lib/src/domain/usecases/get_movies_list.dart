import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/app_errors.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';
import 'package:movie_app/src/domain/entities/usecase.dart';
import 'package:movie_app/src/domain/repositories/account_repository.dart';

@injectable
class GetMoviesList extends UseCase<List<Movie>, GetMoviesListParams> {
  final AccountRepository _accountRepository;

  GetMoviesList(this._accountRepository);

  @override
  Future<Either<AppError, List<Movie>>> call(GetMoviesListParams params) async {
    return await _accountRepository.getMoviesList(params);
  }
}
