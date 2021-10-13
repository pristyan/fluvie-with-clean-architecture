import 'package:fluvie/model/base/result.dart';
import 'package:fluvie/model/view/movie.dart';

abstract class MovieRepository {
  Future<Result> getMovieDetail(String id);

  Future<Result> isFavoriteMovie(Movie movie);

  Future<Result> getFavoriteMovie();

  Future<Result> insertFavoriteMovie(Movie movie);

  Future<Result> deleteFavoriteMovie(Movie movie);
}
