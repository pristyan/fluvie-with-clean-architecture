import 'package:dio/dio.dart';
import 'package:fluvie/constant/api_constant.dart';
import 'package:fluvie/database/app_database.dart';
import 'package:fluvie/network/network_interceptor.dart';

class CoreFactory {
  static Dio? _dio;
  static late AppDatabase _appDatabase;

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

  static Future<bool> initializeDatabase() async {
    _appDatabase = await $FloorAppDatabase.databaseBuilder('movie_app.db').build();
    return true;
  }

  static AppDatabase getAppDatabase() {
    return _appDatabase;
  }
}
