import 'package:get/get.dart';

import '../../base/base_view_model.dart';
import '../../helper/pokemon_helper.dart';
import '../../models/pokemon_detail.dart';

class DetailViewModel extends BaseViewModel {
  RxBool shiny = false.obs;

  triggerShinny() {
    shiny.value = !shiny.value;
  }

  Future<void> releasePokemon(PokemonDetail pokemon)async {
    PokemonHelper.removeFromOwnedPokemon(pokemon);
  }
}