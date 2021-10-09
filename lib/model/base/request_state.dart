import 'package:fluvie/model/base/api_error.dart';

abstract class RequestState {}

class InitialState extends RequestState {}

class SuccessState<T> extends RequestState {
  final T _data;
  T get data => _data;
  SuccessState(this._data);
}

class ErrorState extends RequestState {
  final ApiError error;
  ErrorState(this.error);
}

class LoadingState extends RequestState {
  bool isLoading = false;
  LoadingState(this.isLoading);
}