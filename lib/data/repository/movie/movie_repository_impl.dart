import 'package:fluvie/data/source/local/movie/movie_local_data_source.dart';
import 'package:fluvie/data/source/remote/movie/movie_remote_data_source.dart';
import 'package:fluvie/model/base/result.dart';
import 'package:fluvie/model/base/base_response.dart';
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
}
