import 'package:floor/floor.dart';
import 'package:fluvie/model/view/movie.dart';

@Entity(tableName: 'movie')
class MovieEntity {
  @primaryKey
  final int? id;
  final String? title;
  final String? overview;
  final double? voteAverage;
  final String? posterPath;

  MovieEntity(
    this.id,
    this.title,
    this.overview,
    this.voteAverage,
    this.posterPath,
  );

  factory MovieEntity.fromMovie(Movie movie) {
    return MovieEntity(
      movie.id,
      movie.title,
      movie.overview,
      movie.voteAverage,
      movie.posterPath,
    );
  }
}
