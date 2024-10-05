import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_color.dart';
import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../models/pokemon_detail.dart';
import '../../../utils/get_util.dart';
import '../../../utils/string_util.dart';

class ItemPokemon extends StatelessWidget {
  const ItemPokemon({
    super.key,
    required this.pokemonDetail,
    required this.ownCount,
    required this.onTap,
  });

  final PokemonDetail pokemonDetail;
  final int ownCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.getSize(12),
              vertical: AppSize.getSize(8),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            ),
            child: Text(
              pokemonDetail.id.toString().padLeft(3, '0'),
              style: AppTextStyle.baseTextStyle(
                fontSize: AppSize.getTextSize(12),
              ),
            ),
          ),
          SizedBox(width: AppSize.getSize(24)),
          CachedNetworkImage(width: AppSize.getScreenWidth(percent: 25), errorWidget: (context, url, error) => const Icon(Icons.error), imageUrl: pokemonDetail.sprites?.frontDefault ?? ''),
          SizedBox(width: AppSize.getSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemonDetail.name?.toCapitalized() ?? '',
                  style: AppTextStyle.baseTextStyle(
                    fontWeightType: FontWeightType.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSize.getSize(2)),
                Text(
                  '${'owned'.translate()}: $ownCount',
                  style: AppTextStyle.baseTextStyle(
                    fontWeightType: FontWeightType.medium,
                    fontSize: AppSize.getTextSize(14),
                    color: AppColor.gray,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
