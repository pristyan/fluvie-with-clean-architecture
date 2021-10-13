import 'package:fluvie/data/dao/movie_dao.dart';
import 'package:fluvie/database/app_database.dart';
import 'package:fluvie/model/db/movie_entity.dart';

import 'movie_local_data_source.dart';

class MovieLocalDataSourceImpl implements MovieLocalDataSource {

  final AppDatabase appDatabase;
  MovieDao get _movieDao => appDatabase.movieDao;

  MovieLocalDataSourceImpl({required this.appDatabase});

  @override
  Future<void> deleteFavorite(MovieEntity movieEntity) {
    return _movieDao.deleteFavorite(movieEntity);
  }

  @override
  Future<List<MovieEntity>> getFavorite() {
    return _movieDao.getFavorite();
  }

  @override
  Future<void> insertFavorite(MovieEntity movieEntity) {
    return _movieDao.insertFavorite(movieEntity);
  }
  
}