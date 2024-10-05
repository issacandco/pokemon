import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../models/base_request_model.dart';
import '../models/pokemon_detail.dart';
import '../models/pokemon_list_by_type_response.dart';
import '../models/pokemon_list_response.dart';

class PokemonService {
  PokemonService._internal();

  static final PokemonService _singleton = PokemonService._internal();

  factory PokemonService() {
    return _singleton;
  }

  Future<PokemonListResponse> getPokemonList(String url, {BaseRequestModel? request}) async {
    Response response = await ApiClient.instance.get(url);
    return PokemonListResponse.fromJson(response.data);
  }

  Future<PokemonListResponse> getPokemonTypeList(String url) async {
    Response response = await ApiClient.instance.get(url);
    return PokemonListResponse.fromJson(response.data);
  }

  Future<PokemonListByTypeResponse> getPokemonListBasedOnType({BaseRequestModel? request}) async {
    Response response = await ApiClient.instance.getPokemonBasedOnType(request: request);
    return PokemonListByTypeResponse.fromJson(response.data);
  }

  Future<PokemonDetail> getPokemonDetails(String url) async {
    Response response = await ApiClient.instance.get(url);
    return PokemonDetail.fromJson(response.data);
  }

  Future<PokemonDetail> searchPokemon(BaseRequestModel request) async {
    Response response = await ApiClient.instance.searchPokemon(request: request);
    return PokemonDetail.fromJson(response.data);
  }
}
