import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/src/core/api/api_call_with_error.dart';
import 'package:movie_app/src/data/data_source/remote/account_remote_data_source.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/app_errors.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';
import 'package:movie_app/src/domain/repositories/account_repository.dart';

@LazySingleton(as: AccountRepository)
class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource _accountRemoteDataSource;

  AccountRepositoryImpl(this._accountRemoteDataSource);

  @override
  Future<Either<AppError, List<Movie>>> getMoviesList(
      GetMoviesListParams params) {
    return ApiCallWithError.call(
      () => _accountRemoteDataSource.getMoviesList(params),
    );
  }
}
