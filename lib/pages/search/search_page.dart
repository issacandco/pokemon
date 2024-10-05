import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/asset_util.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../../widgets/base/base_text_field.dart';
import '../../widgets/no_data_widget.dart';
import '../detail/detail_page.dart';
import 'components/item_search_result.dart';
import 'search_view_model.dart';

class SearchPage extends BasePage {
  const SearchPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends BaseState<SearchPage> with BasicPage {
  final TextEditingController _searchTec = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  Timer? _debounce;

  final SearchViewModel _searchViewModel = GetUtil.put(SearchViewModel());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _searchFocusNode.requestFocus();
    });

    _searchTec.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchTec.removeListener(_onSearchChanged);
    _searchTec.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar(
      titleName: 'search'.translate(),
    );
  }

  @override
  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSize.standardSize),
          child: Column(
            children: [
              _buildSearchBar(),
              _buildSearchResult(),
            ],
          ),
        ),
      ),
    );
  }

  _buildSearchBar() => Container(
        margin: EdgeInsets.only(bottom: AppSize.getSize(32)),
        child: BaseTextField(
          controller: _searchTec,
          onTextChanged: (value) {},
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          hintText: 'search_hint'.translate(),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Theme.of(context).iconTheme.color,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSize.getSize(16),
            vertical: AppSize.getSize(8),
          ),
          maxLines: 1,
          inputBorderRadius: AppSize.getSize(24),
          inputBorderColor: Colors.transparent,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {},
        ),
      );

  _buildSearchResult() => GetUtil.getX<SearchViewModel>(builder: (vm) {
        PokemonDetail? pokemonDetail = vm.pokemonDetailStream.value;

        if (pokemonDetail != null && pokemonDetail.name != null) {
          return ItemSearchResult(
            pokemonDetail: pokemonDetail,
            onTap: () {
              GetUtil.navigateTo(DetailPage(pokemonDetail: pokemonDetail));
            },
          );
        } else {
          return NoDataWidget(
            image: AssetUtil.imageOpenedPokeball(size: AppSize.getScreenHeight(percent: 30)),
          );
        }
      });

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchViewModel.onSearchPokemon(_searchTec.text.toLowerCase());
    });
  }
}
