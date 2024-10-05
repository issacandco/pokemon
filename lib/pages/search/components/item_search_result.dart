import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../models/pokemon_detail.dart';
import '../../../utils/string_util.dart';
import '../../detail/components/item_type.dart';

class ItemSearchResult extends StatelessWidget {
  const ItemSearchResult({
    super.key,
    required this.pokemonDetail,
    required this.onTap,
  });

  final PokemonDetail pokemonDetail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: AppSize.getScreenWidth(),
            padding: EdgeInsets.all(AppSize.getSize(16)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: AppSize.getScreenWidth(percent: 30)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildName(),
                          _buildId(),
                          _buildTypes(),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  CupertinoIcons.forward,
                  size: AppSize.getSize(18),
                ),
              ],
            ),
          ),
          _buildImage(),
        ],
      ),
    );
  }

  _buildImage() => Positioned(
        left: -AppSize.getSize(10),
        bottom: 0,
        child: Hero(
          tag: pokemonDetail.name ?? 'unknown',
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            width: AppSize.getScreenWidth(percent: 35),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: pokemonDetail.shiny != null && pokemonDetail.shiny! ? pokemonDetail.sprites?.other?.officialArtwork?.frontShiny ?? '' : pokemonDetail.sprites?.other?.officialArtwork?.frontDefault ?? '',
          ),
        ),
      );

  _buildId() => Container(
        margin: EdgeInsets.only(bottom: AppSize.getSize(8)),
        child: Text(
          '#${pokemonDetail.id.toString().padLeft(3, '0')}',
          style: AppTextStyle.baseTextStyle(
            fontWeightType: FontWeightType.medium,
            fontSize: AppSize.getTextSize(16),
          ),
        ),
      );

  _buildName() => Text(
        pokemonDetail.name?.toCapitalized() ?? '',
        style: AppTextStyle.baseTextStyle(
          fontWeightType: FontWeightType.bold,
          fontSize: AppSize.getTextSize(18),
        ),
      );

  _buildTypes() => Wrap(
        spacing: AppSize.getSize(4),
        children: pokemonDetail.types!.map((pokemonType) => ItemType(type: pokemonType.type?.name ?? '')).toList(),
      );
}
