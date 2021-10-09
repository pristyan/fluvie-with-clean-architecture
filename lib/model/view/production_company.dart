import 'package:json_annotation/json_annotation.dart';

part 'production_company.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompany {
  final int? id;
  final String? name;
  final String? logoPath;
  final String? originCountry;

  ProductionCompany({
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => _$ProductionCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}
