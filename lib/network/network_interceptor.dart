import 'package:dio/dio.dart';
import 'package:fluvie/constant/api_constant.dart';

class NetworkInterceptor extends Interceptor {
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.putIfAbsent('api_key', () => ApiConstant.apiKey);
    super.onRequest(options, handler);
  }
}
