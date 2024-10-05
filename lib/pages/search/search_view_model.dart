import 'package:get/get.dart';

import '../../base/base_view_model.dart';
import '../../models/base_request_model.dart';
import '../../models/pokemon_detail.dart';
import '../../services/pokemon_service.dart';

class SearchViewModel extends BaseViewModel {
  final PokemonService _pokemonService = PokemonService();

  Rxn<PokemonDetail> pokemonDetailStream = Rxn<PokemonDetail>();

  Future<void> onSearchPokemon(String query) async {
    if (query.isEmpty) return;

    try {
      var request = BaseRequestModel(pathParameters: {'query': query});

      final PokemonDetail pokemonDetail = await _pokemonService.searchPokemon(request);

      pokemonDetailStream.value = pokemonDetail;
    } catch (e) {
      print(e.toString());
    }
  }
}
