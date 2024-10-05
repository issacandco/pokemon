import 'dart:developer';

import 'package:get/get.dart';

import '../../app/flavors.dart';
import '../../base/base_view_model.dart';
import '../../helper/pokemon_helper.dart';
import '../../models/base_info.dart';
import '../../models/base_request_model.dart';
import '../../models/pokemon_by_type.dart';
import '../../models/pokemon_detail.dart';
import '../../models/pokemon_list_by_type_response.dart';
import '../../models/pokemon_list_response.dart';
import '../../models/pokemon_type.dart';
import '../../services/pokemon_service.dart';
import '../../utils/get_util.dart';

class PokeDexViewModel extends BaseViewModel {
  final PokemonService _pokemonService = PokemonService();

  RxList<PokemonDetail> pokemonList = <PokemonDetail>[].obs;
  String? nextPageUrl;
  String? nextPageUrlNotOwned;
  RxMap<int, int> ownedPokemonMap = <int, int>{}.obs;
  List<PokemonDetail> ownedPokemonList = [];

  bool filterTypeMode = false;
  bool isNotOwned = false;

  RxString filterText = ''.obs;

  @override
  onInit() async {
    super.onInit();
    await getOwnedPokemonList();
  }

  Future<void> getOwnedPokemonList() async {
    ownedPokemonList = PokemonHelper.getOwnedPokemonList();

    for (var pokemon in ownedPokemonList) {
      if (ownedPokemonMap.containsKey(pokemon.id)) {
        ownedPokemonMap[pokemon.id!] = ownedPokemonMap[pokemon.id]! + 1;
      } else {
        ownedPokemonMap[pokemon.id!] = 1;
      }
    }
  }

  Future<void> getPokemonList({bool isInitialLoad = true}) async {
    try {
      initialLoading();

      isNotOwned = false;
      filterTypeMode = false;

      String url = nextPageUrl ?? '${F.apiBaseUrl}/v2/pokemon';

      final PokemonListResponse response = await _pokemonService.getPokemonList(url);
      final List<BaseInfo> pokemonBaseList = response.results ?? [];

      nextPageUrl = response.next;

      final List<Future<PokemonDetail>> futures = pokemonBaseList.map((pokemon) async {
        String pokemonDetailUrl = pokemon.url!;
        final PokemonDetail detailResponse = await _pokemonService.getPokemonDetails(pokemonDetailUrl);
        return detailResponse;
      }).toList();

      final details = await Future.wait(futures);

      if (isInitialLoad) {
        pokemonList.value = details;
      } else {
        pokemonList.addAll(details);
      }

      doneResponse();
    } catch (e) {
      log('Error fetching Pokémon details: $e');
    }
  }

  Future<void> getNotOwnedPokemonList({bool isInitialLoad = true}) async {
    try {
      initialLoading();

      isNotOwned = true;
      filterTypeMode = false;
      filterText.value = 'not_owned'.translate();

      String url = nextPageUrlNotOwned ?? '${F.apiBaseUrl}/v2/pokemon';

      final PokemonListResponse response = await _pokemonService.getPokemonList(url);
      final List<BaseInfo> pokemonBaseList = response.results ?? [];

      nextPageUrlNotOwned = response.next;

      final List<Future<PokemonDetail>> futures = pokemonBaseList.map((pokemon) async {
        String pokemonDetailUrl = pokemon.url!;
        final PokemonDetail detailResponse = await _pokemonService.getPokemonDetails(pokemonDetailUrl);
        return detailResponse;
      }).toList();

      final details = await Future.wait(futures);

      final filteredDetails = details.where((pokemon) => !ownedPokemonList.any((owned) => owned.id == pokemon.id)).toList();

      if (isInitialLoad) {
        pokemonList.value = filteredDetails;
      } else {
        pokemonList.addAll(filteredDetails);
      }

      doneResponse();
    } catch (e) {
      log('Error fetching Pokémon details: $e');
    }
  }

  Future<void> getPokemonListBasedOnType(PokemonType type) async {
    try {
      initialLoading();

      nextPageUrl = null;
      isNotOwned = false;
      filterTypeMode = true;
      filterText.value = type.type!.name!;

      var request = BaseRequestModel(pathParameters: {
        'query': type.type!.name,
      });

      final PokemonListByTypeResponse response = await _pokemonService.getPokemonListBasedOnType(request: request);
      final List<PokemonByType> pokemonTypeList = response.pokemon ?? [];

      final List<Future<PokemonDetail>> futures = pokemonTypeList.map((pokemonByType) async {
        String pokemonDetailUrl = pokemonByType.pokemon!.url!;
        final PokemonDetail detailResponse = await _pokemonService.getPokemonDetails(pokemonDetailUrl);
        return detailResponse;
      }).toList();

      final details = await Future.wait(futures);

      pokemonList.value = details;

      doneResponse();
    } catch (e) {
      log('Error fetching Pokémon based on type: $e');
    }
  }

  Future<void> getPokemonListBasedOnStringType() async {
    try {
      initialLoading();

      nextPageUrl = null;
      isNotOwned = false;
      filterTypeMode = true;
      filterText.value = 'owned'.translate();

      pokemonList.value = PokemonHelper.getOwnedPokemonList();

      doneResponse();
    } catch (e) {
      log('Error fetching Pokémon based on string type: $e');
    }
  }

  bool get hasMorePages => nextPageUrl != null;

  bool get hasMorePagesNotOwned => nextPageUrlNotOwned != null;

  Future<void> loadMorePokemon() async {
    if (filterTypeMode) return;

    if (isNotOwned) {
      if (hasMorePagesNotOwned) {
        await getNotOwnedPokemonList(isInitialLoad: false);
      }
    } else {
      if (hasMorePages) {
        await getPokemonList(isInitialLoad: false);
      }
    }
  }
}
