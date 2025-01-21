part of 'home_page_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final PagingController<int, Movie> pagingController;

  const HomeLoaded(this.pagingController);

  @override
  List<Object?> get props => [pagingController];
}

class HomeVisitedUpdated extends HomeState {
  final List<Movie> visitedMovies;

  const HomeVisitedUpdated(this.visitedMovies);

  @override
  List<Object?> get props => [visitedMovies];
}
