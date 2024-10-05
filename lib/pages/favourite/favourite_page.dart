import 'package:flutter/cupertino.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../detail/detail_page.dart';
import '../search/components/item_search_result.dart';
import 'favourite_view_model.dart';

class FavouritePage extends BasePage {
  const FavouritePage({super.key});

  @override
  State<StatefulWidget> createState() => _FavouritePageState();
}

class _FavouritePageState extends BaseState<FavouritePage> with BasicPage {
  final FavouriteViewModel _favouriteViewModel = GetUtil.put(FavouriteViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar(titleName: '${'favourite'.translate()} ${'pokemon'.translate()}');
  }

  @override
  Widget body() {
    return SafeArea(
      child: FocusDetector(
        onFocusGained: () {
          _favouriteViewModel.getFavouritePokemonList();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(AppSize.standardSize),
            child: _buildFavouritePokemon(),
          ),
        ),
      ),
    );
  }

  _buildFavouritePokemon() => GetUtil.getX<FavouriteViewModel>(
        builder: (vm) {
          List<PokemonDetail> favouritePokemonList = vm.favouritePokemonList;

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: AppSize.getSize(16)),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ItemSearchResult(
                pokemonDetail: favouritePokemonList[index],
                onTap: () async {
                  dynamic result = await GetUtil.navigateToWithResult(DetailPage(
                    pokemonDetail: favouritePokemonList[index],
                  ));

                  if (result != null && result) {
                    await _favouriteViewModel.getFavouritePokemonList();
                  }
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: AppSize.getSize(24));
            },
            itemCount: favouritePokemonList.length,
          );
        },
      );
}
