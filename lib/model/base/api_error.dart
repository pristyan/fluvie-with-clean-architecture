import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiError {
  final int? statusCode;
  final String? statusMessage;

  ApiError({this.statusCode, this.statusMessage});

  factory ApiError.fromDio(DioError e) {
    if (e.type == DioErrorType.other) {
        return ApiError._noConnection();
      } else if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.sendTimeout) {
        return ApiError._connectionTimeOut();
      } else if (e.type == DioErrorType.receiveTimeout) {
        return ApiError._receiveTimeOut();
      } else if (e.response?.data != null) {
        return ApiError.fromJson(e.response?.data);
      } else {
        return ApiError._unknown(e);
      }
  }

  factory ApiError.general() {
    return ApiError(
      statusCode: -1,
      statusMessage: 'Something wrong, please try again later.',
    );
  }

  factory ApiError._noConnection() {
    return ApiError(
      statusCode: 0,
      statusMessage: 'No internet connection.',
    );
  }

  factory ApiError._connectionTimeOut() {
    return ApiError(
      statusCode: -2,
      statusMessage: 'Make sure you have a proper internet connection.',
    );
  }
  
  factory ApiError._receiveTimeOut() {
    return ApiError(
      statusCode: -3,
      statusMessage: 'Oops, our server is busy. Please try again later.',
    );
  }

  factory ApiError._unknown(DioError e) {
    return ApiError(
      statusCode: -4,
      statusMessage: e.toString(),
    );
  }

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
