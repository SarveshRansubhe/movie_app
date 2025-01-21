part of 'home_page_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoaded extends HomeState {
  final List<Movie> movies;

  const HomeLoaded(this.movies);
  @override
  List<Object> get props => [movies];
}

final class HomeError extends HomeState {
  final AppError appError;

  const HomeError(this.appError);
  @override
  List<Object> get props => [appError];
}
