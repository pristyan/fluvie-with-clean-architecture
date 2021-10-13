import 'package:floor/floor.dart';
import 'package:fluvie/model/db/movie_entity.dart';

@dao
abstract class MovieDao {

  @insert
  Future<void> insertFavorite(MovieEntity movieEntity);

  @Query('SELECT * FROM movie')
  Future<List<MovieEntity>> getFavorite();

  @delete
  Future<void> deleteFavorite(MovieEntity movieEntity);
}