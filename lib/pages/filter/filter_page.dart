import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../models/pokemon_type.dart';
import '../../utils/get_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../detail/components/item_type.dart';
import 'filter_view_model.dart';

class FilterPage extends BasePage {
  const FilterPage({super.key});

  @override
  State<StatefulWidget> createState() => _FilterPageState();
}

class _FilterPageState extends BaseState<FilterPage> with BasicPage {
  final FilterViewModel _filterViewModel = GetUtil.put(FilterViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar(titleName: 'filter'.translate());
  }

  @override
  Widget body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(AppSize.standardSize),
        child: GetUtil.getX<FilterViewModel>(
          builder: (vm) {
            List<PokemonType> pokemonTypeList = vm.pokemonTypeList;
            List<String> otherList = vm.otherList;

            return Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'pokemon_types'.translate(),
                      style: AppTextStyle.baseTextStyle(
                        fontWeightType: FontWeightType.bold,
                        fontSize: AppSize.getTextSize(20),
                      ),
                    ),
                    SizedBox(height: AppSize.getSize(8)),
                    Wrap(
                      runSpacing: AppSize.getSize(16),
                      spacing: AppSize.getSize(16),
                      children: pokemonTypeList
                          .map((type) => InkWell(
                                onTap: () {
                                  GetUtil.backWithResult(type);
                                },
                                child: ItemType(
                                  type: type.type?.name ?? '',
                                  fromFilter: true,
                                ),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: AppSize.getSize(24)),
                    Text(
                      'other'.translate(),
                      style: AppTextStyle.baseTextStyle(
                        fontWeightType: FontWeightType.bold,
                        fontSize: AppSize.getTextSize(20),
                      ),
                    ),
                    SizedBox(height: AppSize.getSize(8)),
                    Wrap(
                      runSpacing: AppSize.getSize(16),
                      spacing: AppSize.getSize(16),
                      children: otherList
                          .map(
                            (type) => InkWell(
                              onTap: () {
                                GetUtil.backWithResult(type);
                              },
                              child: ItemType(
                                type: type,
                                fromFilter: true,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
