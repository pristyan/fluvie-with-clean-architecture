import 'package:fluvie/data/source/local/movie/movie_local_data_source.dart';
import 'package:fluvie/data/source/local/movie/movie_local_data_source_impl.dart';
import 'package:fluvie/data/source/remote/movie/movie_remote_data_source.dart';
import 'package:fluvie/data/source/remote/movie/movie_remote_data_source_impl.dart';
import 'package:fluvie/factory/core_factory.dart';

class DataSourceFactory {

  static MovieLocalDataSource getMovieLocalDataSource() {
    return MovieLocalDataSourceImpl();
  }

  static MovieRemoteDataSource getMovieRemoteDataSource() {
    return MovieRemoteDataSourceImpl(CoreFactory.getDio());
  }

}