import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/data/repository/movie/movie_repository.dart';
import 'package:fluvie/model/base/request_state.dart';
import 'package:fluvie/model/base/result.dart';
import 'package:fluvie/model/view/movie.dart';

class MovieDetailBloc extends Cubit<RequestState> {
  final MovieRepository _movieRepository;

  MovieDetailBloc(
    RequestState state,
    this._movieRepository,
  ) : super(state) {
    getDetail();
  }

  Future<void> getDetail() async {
    emit(LoadingState());
    var result = await _movieRepository.getMovieDetail('580489');
    if (result is Success) {
      emit(SuccessState<Movie>(result.data));
    } else {
      emit(ErrorState.fromResult(result));
    }
  }
  
}