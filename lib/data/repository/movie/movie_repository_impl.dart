import 'package:fluvie/data/source/local/movie/movie_local_data_source.dart';
import 'package:fluvie/data/source/remote/movie/movie_remote_data_source.dart';
import 'package:fluvie/model/base/result.dart';
import 'package:fluvie/model/base/base_response.dart';
import 'package:fluvie/model/db/movie_entity.dart';
import 'package:fluvie/model/view/movie.dart';
import 'movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;
  final MovieLocalDataSource _localDataSource;

  MovieRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result> getMovieDetail(String id) async {
    var response = await _remoteDataSource.getMovieDetail(id);
    if (response is SuccessResponse) {
      return Success(data: response.result);
    } else {
      return Failure.fromResponse(response);
    }
  }

  @override
  Future<Result> deleteFavoriteMovie(Movie movie) async {
    try {
      await _localDataSource.deleteFavorite(
        MovieEntity.fromMovie(movie),
      );
      return Success();
    } catch (e) {
      return Failure(0, Error.safeToString(e));
    }
  }

  @override
  Future<Result> getFavoriteMovie() async {
    try {
      var entities = await _localDataSource.getFavorite();
      var list = entities.map((e) => Movie.fromEntity(e)).toList();
      return Success(data: list);
    } catch (e) {
      return Failure(0, Error.safeToString(e));
    }
  }

  @override
  Future<Result> insertFavoriteMovie(Movie movie) async {
    try {
      await _localDataSource.insertFavorite(
        MovieEntity.fromMovie(movie),
      );
      return Success();
    } catch (e) {
      return Failure(0, 'Failed to add movie from favorite');
    }
  }

  @override
  Future<Result> isFavoriteMovie(Movie movie) async {
    try {
      var favorites = await _localDataSource.getFavorite();
      var isFavorite =
          favorites.where((m) => m.id == movie.id).toList().isNotEmpty;
      return Success(data: isFavorite);
    } catch (e) {
      return Failure(0, 'Failed to check favorite movie');
    }
  }
}
