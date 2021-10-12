import 'package:dio/dio.dart';
import 'package:fluvie/constant/api_constant.dart';
import 'package:fluvie/model/base/base_response.dart';
import 'package:fluvie/model/view/movie.dart';

import 'movie_remote_data_source.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio;

  MovieRemoteDataSourceImpl(this._dio);

  static const String _movie = ApiConstant.apiVersion + "/movie/";

  @override
  Future<BaseResponse> getMovieDetail(String id) async {
    try {
      var response = await _dio.get(_movie + id);
      return SuccessResponse(Movie.fromJson(response.data));
    } catch (e) {
      return ErrorResponse(e);
    }
  }
}
