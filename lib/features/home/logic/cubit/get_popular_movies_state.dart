part of 'get_popular_movies_cubit.dart';

@immutable
sealed class GetPopularMoviesState {}

final class GetPopularMoviesLoading extends GetPopularMoviesState {}

final class GetPopularMoviesLoaded extends GetPopularMoviesState {
  final PopularMoviesModel movies;
  final bool isLoadingMore;
  final bool hasMore;

  GetPopularMoviesLoaded({
    required this.movies,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  GetPopularMoviesLoaded copyWith({
    PopularMoviesModel? movies,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return GetPopularMoviesLoaded(
      movies: movies ?? this.movies,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

final class GetPopularMoviesError extends GetPopularMoviesState {
  final String message;

  GetPopularMoviesError({required this.message});
}
