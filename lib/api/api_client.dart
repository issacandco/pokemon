import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../app/flavors.dart';
import 'api_service.dart';

class ApiClient {
  ApiClient._();

  static final Dio _dio = _createDio();

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        baseUrl: F.apiBaseUrl,
      ),
    );
  }

  static ApiService _apiService() {
    _dio.interceptors.add(
      AwesomeDioInterceptor(
        logResponseHeaders: false,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response<dynamic> response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          return handler.next(e);
        },
      ),
    );

    return ApiService(_dio);
  }

  static final ApiService _instance = _apiService();

  static ApiService get instance {
    return _instance;
  }
}
