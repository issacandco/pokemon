import 'package:get/get.dart';

import '../../base/base_view_model.dart';
import '../../helper/pokemon_helper.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/get_util.dart';

class BackpackViewModel extends BaseViewModel {
  RxList<PokemonDetail> ownedPokemonList = <PokemonDetail>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getOwnedPokemonList();
  }

  Future<void> getOwnedPokemonList() async {
    ownedPokemonList.value = PokemonHelper.getOwnedPokemonList();
  }

  Future<void> sortOwnedPokemonList(String sortBy) async {
    if (sortBy == 'name'.translate()) {
      ownedPokemonList.sort((a, b) => a.name!.compareTo(b.name!));
    } else {
      ownedPokemonList.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }
}
