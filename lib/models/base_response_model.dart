import 'package:json_annotation/json_annotation.dart';

part 'base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseModel<T> {
  final String? status;
  final String? message;
  final T? data;

  BaseResponseModel({this.status, this.message, this.data});

  bool get isSuccess => status != null && (status == 'success');

  factory BaseResponseModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$BaseResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseResponseModelToJson(this, toJsonT);
}
