// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/api/api_client.dart' as _i424;
import '../core/api/injection_module.dart' as _i821;
import '../data/data_source/remote/account_remote_data_source.dart' as _i300;
import '../data/repositories/account_repository_impl.dart' as _i870;
import '../domain/repositories/account_repository.dart' as _i64;
import '../domain/usecases/get_movies_list.dart' as _i854;
import '../presentation/cubits/home_page/home_page_cubit.dart' as _i649;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.factory<String>(
    () => injectionModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i361.Dio>(
      () => injectionModule.dio(gh<String>(instanceName: 'baseUrl')));
  gh.lazySingleton<_i424.ApiClient>(() => _i424.ApiClient(gh<_i361.Dio>()));
  gh.lazySingleton<_i300.AccountRemoteDataSource>(
      () => _i300.AccountRemoteDataSourceImpl(gh<_i424.ApiClient>()));
  gh.lazySingleton<_i64.AccountRepository>(
      () => _i870.AccountRepositoryImpl(gh<_i300.AccountRemoteDataSource>()));
  gh.factory<_i854.GetMoviesList>(
      () => _i854.GetMoviesList(gh<_i64.AccountRepository>()));
  gh.factory<_i649.HomeCubit>(() => _i649.HomeCubit(gh<_i854.GetMoviesList>()));
  return getIt;
}

class _$InjectionModule extends _i821.InjectionModule {}
