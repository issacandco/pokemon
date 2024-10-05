import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable(checked: true)
class CountryModel {
  final int? id;
  final String? name;
  final String? abbreviation;
  final String? phoneCode;
  bool? isSelected;

  CountryModel({
    this.id,
    this.name,
    this.abbreviation,
    this.phoneCode,
    this.isSelected,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
