import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_movies_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class PopularMoviesModel extends HiveObject {
  @HiveField(0)
  final int page;
  @HiveField(1)
  final List<MoviesResult> results;

  PopularMoviesModel({required this.page, required this.results});

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) =>
      _$PopularMoviesModelFromJson(json);

  PopularMoviesModel copyWith({int? page, List<MoviesResult>? results}) {
    return PopularMoviesModel(
      page: page ?? this.page,
      results: results ?? this.results,
    );
  }
}

@HiveType(typeId: 1)
@JsonSerializable()
class MoviesResult {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String overview;
  @HiveField(2)
  @JsonKey(name: 'vote_average')
  final double voteAverage;

  MoviesResult({
    required this.title,
    required this.overview,
    required this.voteAverage,
  });

  factory MoviesResult.fromJson(Map<String, dynamic> json) =>
      _$MoviesResultFromJson(json);
}
