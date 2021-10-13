import 'package:fluvie/model/db/movie_entity.dart';

abstract class MovieLocalDataSource {

  Future<void> insertFavorite(MovieEntity movieEntity);

  Future<void> deleteFavorite(MovieEntity movieEntity);

  Future<List<MovieEntity>> getFavorite();
}
