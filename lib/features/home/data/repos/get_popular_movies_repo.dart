import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movie_mate/core/service/api/api_service.dart';
import 'package:movie_mate/core/service/api/error/api_result.dart';
import 'package:movie_mate/features/home/data/models/popular_movies_model.dart';

import '../../../../core/service/api/error/error_model.dart';
import '../local/movies_local_data_source.dart';

class GetPopularMoviesRepo {
  final ApiService apiService;
  final MoviesLocalDataSource localDataSource;

  GetPopularMoviesRepo({
    required this.apiService,
    required this.localDataSource,
  });

  Future<ApiResult<PopularMoviesModel>> getPopularMovies({
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final cached = localDataSource.getCachedMovies(page);
    final cacheTime = localDataSource.getCacheTime(page);
    try {
      final isCacheValid =
          cacheTime != null &&
          DateTime.now().difference(cacheTime).inMinutes < 60;

      if (isCacheValid && !forceRefresh) {
        final cachedPages = _getPagesUpTo(page);

        if (cachedPages.isNotEmpty) {
          return Success(PopularMoviesModel(page: page, results: cachedPages));
        }
      }

      if (forceRefresh) {
        final connectivityResult = await Connectivity().checkConnectivity();
        final isConnected =
            connectivityResult.isNotEmpty &&
            connectivityResult.first != ConnectivityResult.none;
        if (isConnected) {
          if (cached != null) {
            await localDataSource.clearCache();
          }
        } else {
          if (cached != null) {
            return Success(cached);
          } else {
            return Failure(
              const ErrorModel(
                message: 'No internet and no cached data available',
              ),
            );
          }
        }
      }

      final response = await apiService.getAllPopularMovies(page);

      PopularMoviesModel merged;

      if (page > 1) {
        final previousPages = _getPagesUpTo(page);
        merged = PopularMoviesModel(
          page: response.page,
          results: [...previousPages, ...response.results],
        );
      } else {
        merged = response;
      }

      await localDataSource.cacheMovies(page, response);

      return Success(merged);
    } catch (e) {
      final cachedPages = _getPagesUpTo(page);

      if (cachedPages.isNotEmpty) {
        return Success(PopularMoviesModel(page: page, results: cachedPages));
      }

      return await Failure.handle(e);
    }
  }

  Future<bool> hasCachedMovies(int page) async {
    return localDataSource.hasCachedMovies(page);
  }

  List<MoviesResult> _getPagesUpTo(int page) {
    final pages = <MoviesResult>[];
    for (int i = 1; i <= page; i++) {
      final prev = localDataSource.getCachedMovies(i);
      if (prev != null) {
        pages.addAll(prev.results);
      }
    }
    return pages;
  }
}
