import 'package:dio/dio.dart';

class BaseRequestModel {
  Map<String, dynamic>? pathParameters;
  Map<String, dynamic>? queryParameters;
  dynamic data;
  Options? options;

  BaseRequestModel({
    this.pathParameters,
    this.queryParameters,
    this.data,
    this.options,
  });
}
