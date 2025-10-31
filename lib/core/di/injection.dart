import 'package:get_it/get_it.dart';
import 'package:movie_mate/core/app/theme_cubit/theme_cubit.dart';
import 'package:movie_mate/features/home/logic/cubit/get_popular_movies_cubit.dart';

import '../../features/home/data/local/movies_local_data_source.dart';
import '../../features/home/data/repos/get_popular_movies_repo.dart';
import '../service/api/api_service.dart';

import '../service/api/dio_factory.dart';
import '../service/hive/hive_database.dart';

GetIt sl = GetIt.instance;

void setupInjection() {
  _initCore();
  _home();
}

void _initCore() {
  final dio = DioFactory.getDio();
  sl
    ..registerFactory<ThemeCubit>(() => ThemeCubit())
    ..registerLazySingleton<ApiService>(() => ApiService(dio));
}

void _home() {
  //Hive
  sl.registerLazySingleton<HiveDatabase>(() => HiveDatabase.instance);
  //Data Source
  sl.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSource(
      hiveDatabase: sl(),
      //localDataSource: sl(),
    ),
  );
  //Repo
  sl.registerLazySingleton<GetPopularMoviesRepo>(
    () => GetPopularMoviesRepo(apiService: sl(), localDataSource: sl()),
  );
  //Cubits
  sl.registerFactory<GetPopularMoviesCubit>(() => GetPopularMoviesCubit(sl()));
}
