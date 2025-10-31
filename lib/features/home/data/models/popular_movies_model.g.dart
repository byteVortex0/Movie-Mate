// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movies_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PopularMoviesModelAdapter extends TypeAdapter<PopularMoviesModel> {
  @override
  final int typeId = 0;

  @override
  PopularMoviesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PopularMoviesModel(
      page: fields[0] as int,
      results: (fields[1] as List).cast<MoviesResult>(),
    );
  }

  @override
  void write(BinaryWriter writer, PopularMoviesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PopularMoviesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoviesResultAdapter extends TypeAdapter<MoviesResult> {
  @override
  final int typeId = 1;

  @override
  MoviesResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoviesResult(
      title: fields[0] as String,
      overview: fields[1] as String,
      voteAverage: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MoviesResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.overview)
      ..writeByte(2)
      ..write(obj.voteAverage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMoviesModel _$PopularMoviesModelFromJson(Map<String, dynamic> json) =>
    PopularMoviesModel(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MoviesResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PopularMoviesModelToJson(PopularMoviesModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };

MoviesResult _$MoviesResultFromJson(Map<String, dynamic> json) => MoviesResult(
      title: json['title'] as String,
      overview: json['overview'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
    );

Map<String, dynamic> _$MoviesResultToJson(MoviesResult instance) =>
    <String, dynamic>{
      'title': instance.title,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
    };
