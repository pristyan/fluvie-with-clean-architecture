import 'package:fluvie/model/base/base_response.dart';

abstract class MovieRemoteDataSource {
  Future<BaseResponse> getMovieDetail(String id);
}
