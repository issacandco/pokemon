import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/asset_util.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../../widgets/no_data_widget.dart';
import '../detail/detail_page.dart';
import '../search/components/item_search_result.dart';
import '../sort/sort_page.dart';
import 'backpack_view_model.dart';

class BackpackPage extends BasePage {
  const BackpackPage({super.key});

  @override
  State<StatefulWidget> createState() => _BackpackPageState();
}

class _BackpackPageState extends BaseState<BackpackPage> with BasicPage {
  final BackpackViewModel _backpackViewModel = GetUtil.put(BackpackViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar(
      titleName: 'backpack'.translate(),
      appBarActions: [
        IconButton(
          onPressed: () async {
            dynamic result = await GetUtil.navigateToWithResult(const SortPage());

            if (result != null && result is String) {
              _backpackViewModel.sortOwnedPokemonList(result);
            }
          },
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSize.standardSize),
          child: _buildOwnedPokemon(),
        ),
      ),
    );
  }

  _buildOwnedPokemon() => GetUtil.getX<BackpackViewModel>(
        builder: (vm) {
          List<PokemonDetail> ownedPokemonList = vm.ownedPokemonList;

          if (ownedPokemonList.isEmpty) {
            return NoDataWidget(image: AssetUtil.imageOpenedPokeball());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'owned'.translate()} ${'pokemon'.translate()}',
                  style: AppTextStyle.baseTextStyle(
                    fontWeightType: FontWeightType.bold,
                    fontSize: AppSize.getTextSize(22),
                  ),
                ),
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: AppSize.getSize(16)),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ItemSearchResult(
                      pokemonDetail: ownedPokemonList[index],
                      onTap: () async {
                        dynamic result = await GetUtil.navigateToWithResult(DetailPage(
                          pokemonDetail: ownedPokemonList[index],
                          fromOwned: true,
                        ));

                        if (result != null && result) {
                          await _backpackViewModel.getOwnedPokemonList();
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: AppSize.getSize(24));
                  },
                  itemCount: ownedPokemonList.length,
                ),
              ],
            );
          }
        },
      );
}
