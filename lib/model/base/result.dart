import 'package:fluvie/model/base/base_response.dart';

abstract class Result {}

class Success<T> extends Result {
  T? data;
  Success({this.data});
}

class Failure extends Result {
  late int code;
  late String message;

  factory Failure.fromResponse(BaseResponse response) {
    return Failure(
      response.result.statusCode ?? -100,
      response.result.statusMessage ?? '',
    );
  }

  Failure(this.code, this.message);
}
