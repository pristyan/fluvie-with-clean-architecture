import 'package:fluvie/data/repository/movie/movie_repository.dart';
import 'package:fluvie/data/repository/movie/movie_repository_impl.dart';
import 'package:fluvie/factory/data_source_factory.dart';

class RepositoryFactory {

  static MovieRepository getMovieRepository() {
    return MovieRepositoryImpl(
      DataSourceFactory.getMovieLocalDataSource(),
      DataSourceFactory.getMovieRemoteDataSource(),
    );
  }
}
