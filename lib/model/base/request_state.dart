import 'package:fluvie/model/base/result.dart';

abstract class RequestState {}

class InitialState extends RequestState {}

class SuccessState<T> extends RequestState {
  final T data;
  SuccessState(this.data);
}

class ErrorState extends RequestState {
  int code;
  String message;

  ErrorState(this.code, this.message);

  factory ErrorState.fromResult(Result result) {
    var failure = result as Failure;
    return ErrorState(failure.code, failure.message);
  }
}

class LoadingState extends RequestState {}
