import 'package:dio/dio.dart';
import 'package:fluvie/model/base/api_error.dart';

abstract class BaseResponse<T> {
  T? data;
  
  ApiError? error;

  BaseResponse.success({this.data});

  BaseResponse.error(e) {
    if (e is DioError) {
      error = ApiError.fromDio(e);
    } else {
      error = ApiError(statusCode: -1, statusMessage: Error.safeToString(e));
    }
  }
}

class SuccessResponse<T> extends BaseResponse<T> {
  SuccessResponse(data) : super.success(data: data);
}

class ErrorResponse<T> extends BaseResponse<T> {
  ErrorResponse(e) : super.error(e);
}
