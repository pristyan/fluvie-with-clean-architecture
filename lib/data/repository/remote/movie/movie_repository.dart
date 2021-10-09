import 'package:fluvie/model/base/base_response.dart';
import 'package:fluvie/model/view/movie.dart';

abstract class MovieRepository {

  Future<BaseResponse<Movie>> getMovieDetail(String id);
  
}
