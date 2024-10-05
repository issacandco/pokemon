import 'package:dio/dio.dart';

import '../models/base_request_model.dart';

enum RequestType { get, post, put, patch, delete }

class ApiServiceHandler {
  final Dio _dio;
  String? baseUrl;

  ApiServiceHandler(
    this._dio, {
    this.baseUrl,
  });

  Future<Response> request(
    RequestType requestType,
    String path, {
    BaseRequestModel? requestData,
  }) async {
    try {
      Response response;
      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(
            _buildPath(path, requestData?.pathParameters),
            queryParameters: requestData?.queryParameters,
            options: requestData?.options,
          );
          break;
        case RequestType.post:
          response = await _dio.post(
            _buildPath(path, requestData?.pathParameters),
            data: requestData?.data,
            queryParameters: requestData?.queryParameters,
            options: requestData?.options,
          );
          break;
        case RequestType.put:
          response = await _dio.put(
            _buildPath(path, requestData?.pathParameters),
            data: requestData?.data,
            queryParameters: requestData?.queryParameters,
            options: requestData?.options,
          );
          break;
        case RequestType.patch:
          response = await _dio.patch(
            _buildPath(path, requestData?.pathParameters),
            data: requestData?.data,
            queryParameters: requestData?.queryParameters,
            options: requestData?.options,
          );
          break;
        case RequestType.delete:
          response = await _dio.delete(
            _buildPath(path, requestData?.pathParameters),
            data: requestData?.data,
            queryParameters: requestData?.queryParameters,
            options: requestData?.options,
          );
          break;
      }
      return response;
    } on DioException catch (dioException) {
      return Response(
        requestOptions: dioException.requestOptions,
        statusCode: dioException.response?.statusCode,
        data: {
          'message': dioException.message,
          'error': dioException.error,
          'statusCode': dioException.response?.statusCode,
        },
      );
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        data: {
          'message': 'An unexpected error occurred',
          'error': e.toString(),
          'statusCode': 500,
        },
      );
    }
  }

  String _buildPath(String path, Map<String, dynamic>? pathParameters) {
    if (pathParameters != null) {
      pathParameters.forEach((key, value) {
        path = path.replaceAll(':$key', value.toString());
      });
    }
    return _combineBaseUrls(baseUrl) + path;
  }

  String _combineBaseUrls(String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return _dio.options.baseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(_dio.options.baseUrl).resolveUri(url).toString();
  }
}
