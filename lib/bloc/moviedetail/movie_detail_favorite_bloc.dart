import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/data/repository/movie/movie_repository.dart';
import 'package:fluvie/model/base/result.dart';
import 'package:fluvie/model/view/movie.dart';

class MovieDetailFavoriteBloc extends Cubit<bool> {
  final MovieRepository _movieRepository;

  MovieDetailFavoriteBloc(
    bool initialState,
    this._movieRepository,
  ) : super(initialState);

  void checkFavorite(Movie movie) async {
    var result = await _movieRepository.isFavoriteMovie(movie);
    if (result is Success) {
      emit(result.data);
    } else {
      emit(false);
    }
  }

  void toggleFavorite(Movie movie) async {
    if (state) {
      await _movieRepository.deleteFavoriteMovie(movie);
    } else {
      await _movieRepository.insertFavoriteMovie(movie);
    }
    emit(!state);
  }
}
