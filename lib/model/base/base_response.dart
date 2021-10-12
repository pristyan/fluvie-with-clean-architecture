import 'package:dio/dio.dart';
import 'package:fluvie/model/base/api_error.dart';

abstract class BaseResponse<T> {
  T? result;
  BaseResponse({this.result});
}

class SuccessResponse<T> extends BaseResponse<T> {
  SuccessResponse(T result) : super(result: result);
}

class ErrorResponse extends BaseResponse<ApiError> {
  ErrorResponse(e) {
    if (e is DioError) {
      result = ApiError.fromDio(e);
    } else {
      result = ApiError(statusCode: -1, statusMessage: Error.safeToString(e));
    }
  }
}
