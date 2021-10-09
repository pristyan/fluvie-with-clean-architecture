import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/data/repository/remote/movie/movie_repository.dart';
import 'package:fluvie/model/base/api_error.dart';
import 'package:fluvie/model/base/base_response.dart';
import 'package:fluvie/model/base/request_state.dart';

class DetailBloc extends Cubit<RequestState> {
  final MovieRepository _movieRepository;

  DetailBloc(
    RequestState initialState,
    this._movieRepository,
  ) : super(initialState);

  void getDetail() async {
    emit(LoadingState(true));

    var response = await _movieRepository.getMovieDetail('580489');

    if (response is SuccessResponse) {
      emit(SuccessState(response.data));
    } else {
      emit(ErrorState(response.error ??= ApiError.general()));
    }
  }
}
