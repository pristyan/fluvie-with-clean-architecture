import 'package:dio/dio.dart';
import 'package:fluvie/constant/api_constant.dart';
import 'package:fluvie/network/network_interceptor.dart';

class CoreFactory {
  static Dio? _dio;

  static Dio getDio() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: ApiConstant.connectTimeout,
        sendTimeout: ApiConstant.sendTimeout,
        receiveTimeout: ApiConstant.receiveTimeout,
      ),
    );

    _dio?.interceptors.add(NetworkInterceptor());
    _dio?.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
    return _dio as Dio;
  }
}
