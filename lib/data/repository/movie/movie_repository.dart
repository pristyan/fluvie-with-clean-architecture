import 'package:fluvie/model/base/result.dart';

abstract class MovieRepository {
  Future<Result> getMovieDetail(String id);
}
