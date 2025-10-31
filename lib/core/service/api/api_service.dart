import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/home/data/models/popular_movies_model.dart';

part 'api_service.g.dart';

const String baseUrl = 'https://api.themoviedb.org/3/';

@RestApi(baseUrl: baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("movie/popular")
  Future<PopularMoviesModel> getAllPopularMovies(@Query("page") int page);
}
