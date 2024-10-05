import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../models/pokemon_detail.dart';
import '../../models/pokemon_type.dart';
import '../../utils/get_util.dart';
import '../../utils/string_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../../widgets/base/base_loading.dart';
import '../detail/detail_page.dart';
import '../filter/filter_page.dart';
import 'components/item_pokemon.dart';
import 'pokedex_view_model.dart';

class PokedexPage extends BasePage {
  const PokedexPage({super.key});

  @override
  State<StatefulWidget> createState() => _PokedexPageState();
}

class _PokedexPageState extends BaseState<PokedexPage> with BasicPage {
  final PokeDexViewModel _pokeDexViewModel = GetUtil.put(PokeDexViewModel());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _pokeDexViewModel.getPokemonList();
    });

    _pokeDexViewModel.addResponseListener(
      onLoadingResponse: () {
        BaseLoading.showLoading();
      },
      onDoneResponse: () {
        BaseLoading.dismissLoading();
      },
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _pokeDexViewModel.loadMorePokemon();
      }
    });
  }

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar(
      titleName: 'pokedex'.translate(),
      appBarActions: [
        IconButton(
            onPressed: () async {
              dynamic result = await GetUtil.navigateToWithResult(const FilterPage());

              if (result != null && result is PokemonType) {
                _pokeDexViewModel.getPokemonListBasedOnType(result);
              } else if (result != null && result is String) {
                if (result == 'owned'.translate()) {
                  _pokeDexViewModel.getPokemonListBasedOnStringType();
                } else {
                  _pokeDexViewModel.getNotOwnedPokemonList();
                }
              }
            },
            icon: const Icon(Icons.filter_list))
      ],
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.standardSize),
        child: GetUtil.getX<PokeDexViewModel>(builder: (vm) {
          List<PokemonDetail> pokemonList = vm.pokemonList;
          Map<int, int> ownedPokemonMap = vm.ownedPokemonMap;
          String filterText = vm.filterText.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: filterText.isNotEmpty,
                child: Container(
                  padding: EdgeInsets.only(top: AppSize.getSize(8)),
                  child: Text(
                    '${'filter'.translate()}: ${filterText.toCapitalized()}',
                    style: AppTextStyle.baseTextStyle(
                      fontWeightType: FontWeightType.bold,
                      fontSize: AppSize.getSize(18),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ItemPokemon(
                      pokemonDetail: pokemonList[index],
                      ownCount: ownedPokemonMap[pokemonList[index].id] ?? 0,
                      onTap: () {
                        GetUtil.navigateTo(DetailPage(pokemonDetail: pokemonList[index]));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: AppSize.getSize(8));
                  },
                  itemCount: pokemonList.length,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
