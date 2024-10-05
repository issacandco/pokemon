import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import '../../constants/app_color.dart';
import '../../constants/app_size.dart';
import '../../constants/app_text_style.dart';
import '../../helper/pokemon_helper.dart';
import '../../models/pokemon_detail.dart';
import '../../utils/get_util.dart';
import '../../utils/string_util.dart';
import '../../widgets/base/base_app_bar.dart';
import '../../widgets/base/base_button.dart';
import '../../widgets/base/base_dialog.dart';
import '../../widgets/base/base_switch.dart';
import 'components/item_stat.dart';
import 'components/item_type.dart';
import 'detail_view_model.dart';

class DetailPage extends BasePage {
  const DetailPage({
    super.key,
    required this.pokemonDetail,
    this.fromOwned = false,
  });

  final PokemonDetail pokemonDetail;
  final bool fromOwned;

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends BaseState<DetailPage> with BasicPage {
  final DetailViewModel _detailViewModel = GetUtil.put(DetailViewModel());

  @override
  PreferredSizeWidget? appBar() {
    return BaseAppBar();
  }

  @override
  Widget body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSize.standardSize),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: AppSize.getSize(120)),
                    width: AppSize.getScreenWidth(),
                    padding: EdgeInsets.all(AppSize.getSize(16)),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(AppSize.getSize(16)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppSize.getSize(20),
                        ),
                        _buildIdAndFavourite(),
                        SizedBox(height: AppSize.getSize(4)),
                        _buildName(),
                        SizedBox(height: AppSize.getSize(16)),
                        _buildTypes(),
                        SizedBox(height: AppSize.getSize(16)),
                        _buildAbilities(),
                        SizedBox(height: AppSize.getSize(16)),
                        _buildStats(),
                        SizedBox(height: AppSize.getSize(16)),
                        _buildShiny(),
                      ],
                    ),
                  ),
                  _buildImage(),
                ],
              ),
              _buildReleaseButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildIdAndFavourite() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '#${widget.pokemonDetail.id.toString().padLeft(3, '0')}',
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.medium,
              fontSize: AppSize.getTextSize(16),
            ),
          ),
          Visibility(
            visible: PokemonHelper.checkIsFavouriteByPokemonId(widget.pokemonDetail.id ?? 0),
            replacement: IconButton(
              onPressed: () {
                setState(() {
                  PokemonHelper.addToFavourite(widget.pokemonDetail);
                });
              },
              icon: const Icon(Icons.favorite_border),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  PokemonHelper.removeFromFavourite(widget.pokemonDetail.id ?? 0);
                });
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      );

  _buildName() => Row(
        children: [
          Text(
            widget.pokemonDetail.name?.toCapitalized() ?? '',
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.bold,
              fontSize: AppSize.getTextSize(22),
            ),
          ),
          SizedBox(width: AppSize.getSize(4)),
          Visibility(
            visible: widget.fromOwned,
            child: Icon(
              widget.pokemonDetail.gender == 'Male' ? Icons.male : Icons.female,
              color: widget.pokemonDetail.gender == 'Male' ? AppColor.blue : AppColor.pink,
            ),
          ),
        ],
      );

  _buildTypes() => Wrap(
        spacing: AppSize.getSize(4),
        children: widget.pokemonDetail.types!.map((pokemonType) => ItemType(type: pokemonType.type?.name ?? '')).toList(),
      );

  _buildAbilities() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'abilities'.translate(),
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.bold,
              fontSize: AppSize.getTextSize(18),
            ),
          ),
          SizedBox(height: AppSize.getSize(4)),
          Text(
            '${widget.pokemonDetail.abilities?.map((ability) => ability.ability?.name?.toCapitalized()).toList().join(', ')}',
            style: AppTextStyle.baseTextStyle(),
          ),
        ],
      );

  _buildStats() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'stats'.translate(),
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.bold,
              fontSize: AppSize.getTextSize(18),
            ),
          ),
          SizedBox(height: AppSize.getSize(4)),
          ...widget.pokemonDetail.stats!.map((stat) => ItemStat(stat: stat.stat?.name ?? '', value: stat.baseStat.toString())),
        ],
      );

  _buildShinyBadge() => Visibility(
        visible: widget.pokemonDetail.shiny ?? false,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.getSize(8),
            vertical: AppSize.getSize(4),
          ),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(AppSize.getSize(8)),
          ),
          child: Text(
            'shiny'.translate(),
            style: AppTextStyle.baseTextStyle(
              fontWeightType: FontWeightType.semiBold,
              fontSize: AppSize.getTextSize(14),
              color: AppColor.black,
            ),
          ),
        ),
      );

  _buildImage() => Positioned(
        top: -AppSize.getSize(70),
        child: Hero(
          tag: widget.pokemonDetail.name ?? '',
          child: widget.fromOwned
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: AppSize.getScreenWidth(percent: 60),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: widget.pokemonDetail.shiny! ? widget.pokemonDetail.sprites?.other?.home?.frontShiny ?? '' : widget.pokemonDetail.sprites?.other?.home?.frontDefault ?? '',
                )
              : GetUtil.getObx(
                  () => CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: AppSize.getScreenWidth(percent: 60),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    imageUrl: _detailViewModel.shiny.value ? widget.pokemonDetail.sprites?.other?.officialArtwork?.frontShiny ?? '' : widget.pokemonDetail.sprites?.other?.officialArtwork?.frontDefault ?? '',
                  ),
                ),
        ),
      );

  _buildShiny() => Visibility(
        visible: !widget.fromOwned,
        replacement: _buildShinyBadge(),
        child: GetUtil.getObx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'shiny'.translate(),
                style: AppTextStyle.baseTextStyle(
                  fontWeightType: FontWeightType.bold,
                  fontSize: AppSize.getTextSize(18),
                ),
              ),
              BaseSwitch(
                value: _detailViewModel.shiny.value,
                onChanged: (value) {
                  _detailViewModel.triggerShinny();
                },
              )
            ],
          ),
        ),
      );

  _buildReleaseButton() => Visibility(
        visible: widget.fromOwned,
        child: Container(
          margin: EdgeInsets.only(top: AppSize.getSize(24)),
          child: BaseButton(
            fitType: FitType.fit,
            onPressed: () {
              BaseDialog.show(
                message: 'confirm_release'.translateWithParams({'name': widget.pokemonDetail.name.toString().toCapitalized()}),
                positiveAction: () async {
                  await _detailViewModel.releasePokemon(widget.pokemonDetail);
                  BaseDialog.show(
                    message: 'success_release'.translate(),
                    positiveAction: () {
                      GetUtil.backWithResult(true);
                    },
                  );
                },
                negativeAction: () {},
                positiveLabel: 'confirm'.translate(),
                negativeLabel: 'cancel'.translate(),
              );
            },
            text: 'release'.translate(),
          ),
        ),
      );
}
