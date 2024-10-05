import 'package:get/get.dart';

import '../../base/base_view_model.dart';
import '../../helper/pokemon_helper.dart';
import '../../models/pokemon_detail.dart';

class FavouriteViewModel extends BaseViewModel {
  RxList<PokemonDetail> favouritePokemonList = <PokemonDetail>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getFavouritePokemonList();
  }

  Future<void> getFavouritePokemonList() async {
    favouritePokemonList.value = PokemonHelper.getFavouritePokemonList();
  }
}