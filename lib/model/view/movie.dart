import 'package:fluvie/model/view/genre.dart';
import 'package:fluvie/model/view/production_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  final int? id;
  final String? title;
  final String? overview;
  final double? voteAverage;
  final String? posterPath;
  final bool? adult;
  final String? backdropPath;
  final String? homepage;
  final String? originalLanguage;
  final String? originalTitle;
  final double? popularity;
  final String? releaseDate;
  final List<Genre>? genres;
  final List<ProductionCompany>? productionCompanies;

  Movie({
    this.id,
    this.title,
    this.overview,
    this.voteAverage,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.homepage,
    this.originalLanguage,
    this.originalTitle,
    this.popularity,
    this.releaseDate,
    this.genres,
    this.productionCompanies,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

}