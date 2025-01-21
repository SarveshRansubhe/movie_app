import 'package:injectable/injectable.dart';
import 'package:movie_app/src/core/api/api_client.dart';
import 'package:movie_app/src/core/api/api_constants.dart';
import 'package:movie_app/src/data/model/movie.dart';
import 'package:movie_app/src/domain/entities/params/get_movies_list_params.dart';

abstract class AccountRemoteDataSource {
  Future<List<Movie>> getMoviesList(GetMoviesListParams params);
}

@LazySingleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiClient _client;

  AccountRemoteDataSourceImpl(this._client);

  @override
  Future<List<Movie>> getMoviesList(GetMoviesListParams params) async {
    final response = await _client.get(
      ApiConstants.discoverMovie,
      queryParameters: params.toJson(),
    );
    return Movie.moviesListFromJson(response);
  }
}
