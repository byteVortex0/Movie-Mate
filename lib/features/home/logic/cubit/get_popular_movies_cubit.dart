import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/service/api/error/api_result.dart';
import 'package:movie_mate/features/home/data/repos/get_popular_movies_repo.dart';

import '../../data/models/popular_movies_model.dart';

part 'get_popular_movies_state.dart';

class GetPopularMoviesCubit extends Cubit<GetPopularMoviesState> {
  GetPopularMoviesCubit(this.getPopularMoviesRepo)
    : super(GetPopularMoviesLoading());

  final GetPopularMoviesRepo getPopularMoviesRepo;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  Future<void> fetchPopularMovies({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      _currentPage = 1;
    }

    final currentState = state;
    if (page == 1) {
      emit(GetPopularMoviesLoading());
    } else {
      if (currentState is GetPopularMoviesLoaded) {
        emit(currentState.copyWith(isLoadingMore: true));
      }
    }

    final result = await getPopularMoviesRepo.getPopularMovies(
      page: page,
      forceRefresh: forceRefresh,
    );

    if (result is Success<PopularMoviesModel>) {
      emit(
        GetPopularMoviesLoaded(
          movies: result.data,
          hasMore: result.data.results.isNotEmpty,
        ),
      );
    } else if (result is Failure<PopularMoviesModel>) {
      if (result.errorModel.message.contains('Invalid page')) {
        if (currentState is GetPopularMoviesLoaded) {
          emit(currentState.copyWith(isLoadingMore: false, hasMore: false));
        }
      } else {
        emit(GetPopularMoviesError(message: result.errorModel.message));
      }
    } else {
      emit(GetPopularMoviesError(message: 'Unknown error occurred'));
    }
  }

  Future<void> loadMoreMovies() async {
    if (_isLoadingMore) return;

    _isLoadingMore = true;

    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected =
        connectivityResult.isNotEmpty &&
        connectivityResult.first != ConnectivityResult.none;

    final nextPage = _currentPage + 1;

    final hasCache = await getPopularMoviesRepo.hasCachedMovies(nextPage);

    if (!isConnected && !hasCache) {
      _isLoadingMore = false;
      return;
    }

    try {
      await fetchPopularMovies(page: nextPage);
      _currentPage = nextPage;
    } finally {
      _isLoadingMore = false;
    }
  }
}
