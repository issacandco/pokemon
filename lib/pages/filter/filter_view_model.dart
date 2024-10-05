import 'dart:developer';

import 'package:get/get.dart';

import '../../app/flavors.dart';
import '../../base/base_view_model.dart';
import '../../models/base_info.dart';
import '../../models/pokemon_list_response.dart';
import '../../models/pokemon_type.dart';
import '../../services/pokemon_service.dart';
import '../../utils/get_util.dart';

class FilterViewModel extends BaseViewModel {
  final PokemonService _pokemonService = PokemonService();

  RxList<PokemonType> pokemonTypeList = <PokemonType>[].obs;
  RxList<String> otherList = <String>['owned'.translate(), 'not_owned'.translate(),].obs;
  String? nextPageUrl;

  @override
  onInit() {
    super.onInit();

    fetchAllPokemonTypes();
  }

  Future<void> fetchAllPokemonTypes() async {
    try {
      String url = nextPageUrl ?? '${F.apiBaseUrl}/v2/type';

      final PokemonListResponse response = await _pokemonService.getPokemonList(url);
      final List<BaseInfo> typeBaseList = response.results ?? [];

      pokemonTypeList.addAll(typeBaseList.map((type) => PokemonType(type: type)));

      nextPageUrl = response.next;

      if (nextPageUrl != null) {
        await fetchAllPokemonTypes();
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }
}
