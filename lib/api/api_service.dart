import 'package:dio/dio.dart';
import '../models/base_request_model.dart';
import 'api_service_handler.dart';

class ApiService {
  final Dio _dio;
  final String? baseUrl;

  late final ApiServiceHandler _apiServiceHandler;

  ApiService(this._dio, {this.baseUrl}) {
    _apiServiceHandler = ApiServiceHandler(_dio, baseUrl: baseUrl);
  }

  ApiServiceHandler get apiServiceUtil => _apiServiceHandler;

  Future<Response> get(String url) {
    return _dio.get(url);
  }

  Future<Response> searchPokemon({BaseRequestModel? request}) {
    return apiServiceUtil.request(RequestType.get, '/v2/pokemon/:query', requestData: request);
  }

  Future<Response> getPokemonBasedOnType({BaseRequestModel? request}) {
    return apiServiceUtil.request(RequestType.get, '/v2/type/:query', requestData: request);
  }
}
