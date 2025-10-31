// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../core/service/hive/hive_database.dart';
import '../models/popular_movies_model.dart';

class MoviesLocalDataSource {
  HiveDatabase hiveDatabase;

  MoviesLocalDataSource({required this.hiveDatabase});

  PopularMoviesModel? getCachedMovies(int page) =>
      hiveDatabase.moviesBox?.get('popular_movies_page_$page');

  DateTime? getCacheTime(int page) {
    final timestamp = hiveDatabase.moviesCacheTimeBox?.get(
      'popular_movies_page_$page',
    );
    return timestamp != null ? DateTime.tryParse(timestamp) : null;
  }

  Future<void> cacheMovies(int page, PopularMoviesModel model) async {
    await hiveDatabase.moviesBox?.put('popular_movies_page_$page', model);
    await hiveDatabase.moviesCacheTimeBox?.put(
      'popular_movies_page_$page',
      DateTime.now().toIso8601String(),
    );
  }

  bool hasCachedMovies(int page) {
    final cached = getCachedMovies(page);
    return cached != null;
  }

  Future<void> clearCache() async {
    await hiveDatabase.clearAllBoxs();
  }
}
