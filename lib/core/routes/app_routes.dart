import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/di/injection.dart';
import 'package:movie_mate/features/home/logic/cubit/get_popular_movies_cubit.dart';
import '../../features/home/data/models/popular_movies_model.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/movieDetails/ui/movie_details_screen.dart';
import 'base_routes.dart';

class AppRoutes {
  static const String home = 'home';
  static const String movieDetails = 'movieDetails';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case home:
        return BaseRoutes(
          page: BlocProvider(
            create: (context) =>
                sl<GetPopularMoviesCubit>()..fetchPopularMovies(),
            child: HomeScreen(),
          ),
        );
      case movieDetails:
        args as Map<String, dynamic>;
        final MoviesResult movie = args['movie'];
        final String posterImage = args['posterImage'];
        return BaseRoutes(
          page: MovieDetailsScreen(movie: movie, posterImage: posterImage),
        );
      default:
        return null;
    }
  }
}
