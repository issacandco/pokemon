import 'package:get/get.dart';

import '../../base/base_view_model.dart';
import '../../helper/pokemon_helper.dart';

class LandingViewModel extends BaseViewModel {
  RxInt ownedCount = 0.obs;
  RxInt releasedCount = 0.obs;
  RxInt fleeCount = 0.obs;

  @override
  onInit() {
    super.onInit();

    updateCount();
  }

  updateCount() {
    ownedCount.value = PokemonHelper.getOwnedCount();
    releasedCount.value = PokemonHelper.getReleasedCount();
    fleeCount.value = PokemonHelper.getFleeCount();
  }
}
