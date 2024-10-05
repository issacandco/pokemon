import 'dart:math';

import 'package:get/get.dart';

import '../../base/base_view_model.dart';
import '../../helper/pokemon_helper.dart';
import '../../models/base_request_model.dart';
import '../../models/pokemon_detail.dart';
import '../../services/pokemon_service.dart';

enum CatchResult { success, fail, flee }

class EncounterViewModel extends BaseViewModel {
  Rx<PokemonDetail> wildPokemon = PokemonDetail().obs;
  RxBool catchMode = false.obs;
  RxInt fleeRate = 0.obs;
  RxInt catchSuccessRate = 0.obs;

  final PokemonService _pokemonService = PokemonService();

  @override
  void onInit() {
    super.onInit();
    randomWildPokemon();
  }

  triggerCatchMode() {
    catchMode.value = !catchMode.value;
  }

  void randomWildPokemon() {
    int totalPokemonCount = 1025;
    int randomIndex = Random().nextInt(totalPokemonCount) + 1;
    print(randomIndex);

    fetchPokemonDetail(randomIndex);

    fleeRate.value = Random().nextInt(31) + 50;
    catchSuccessRate.value = Random().nextInt(76) + 25;
  }

  Future<void> fetchPokemonDetail(int id) async {
    try {
      initialLoading();
      var request = BaseRequestModel(pathParameters: {'query': id});

      final PokemonDetail pokemonDetail = await _pokemonService.searchPokemon(request);

      bool shiny = Random().nextBool();
      String gender = Random().nextBool() ? 'Male' : 'Female';

      pokemonDetail.shiny = shiny;
      pokemonDetail.gender = gender;

      wildPokemon.value = pokemonDetail;

      doneResponse();
    } catch (e) {
      print('Error fetching Pokémon details: $e');
    }
  }

  CatchResult attemptCatch() {
    if (Random().nextInt(100) < catchSuccessRate.value) {
      PokemonHelper.addToOwnedPokemon(wildPokemon.value);
      return CatchResult.success;
    } else {
      fleeRate += Random().nextInt(11) + 10; // Random the flee rate 10~20%
      if (fleeRate >= 100) {
        PokemonHelper.increaseFleeCount();
        return CatchResult.flee;
      }
    }
    return CatchResult.fail;
  }
}
