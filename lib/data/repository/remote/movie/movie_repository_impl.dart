import 'package:fluvie/data/datasource/local/movie/movie_local_data_source.dart';
import 'package:fluvie/data/datasource/remote/movie/movie_remote_data_source.dart';
import 'package:fluvie/data/repository/remote/movie/movie_repository.dart';
import 'package:fluvie/model/view/movie.dart';
import 'package:fluvie/model/base/base_response.dart';

class MovieRepositoryImpl implements MovieRepository {

  final MovieRemoteDataSource _remoteDataSource;
  final MovieLocalDataSource _localDataSource;

  MovieRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<BaseResponse<Movie>> getMovieDetail(String id) {
    return _remoteDataSource.getMovieDetail(id);
  }

}