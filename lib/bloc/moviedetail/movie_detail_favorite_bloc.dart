import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluvie/data/repository/movie/movie_repository.dart';

class MovieDetailFavoriteBloc extends Cubit<bool> {
  MovieRepository _movieRepository;

  MovieDetailFavoriteBloc(
    bool initialState,
    this._movieRepository,
  ) : super(initialState);

  void toggleFavorite() async {
    emit(!state);
  }
}
