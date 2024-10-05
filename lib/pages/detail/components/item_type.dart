import 'package:flutter/material.dart';

import '../../../constants/app_size.dart';
import '../../../constants/app_text_style.dart';
import '../../../utils/string_util.dart';

class ItemType extends StatelessWidget {
  const ItemType({
    super.key,
    required this.type,
    this.fromFilter = false,
  });

  final String type;
  final bool fromFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fromFilter ? AppSize.getSize(16) : AppSize.getSize(8),
        vertical: fromFilter ? AppSize.getSize(8) : AppSize.getSize(4),
      ),
      decoration: BoxDecoration(
        color: _getPokemonTypeColor()['background'],
        borderRadius: BorderRadius.circular(AppSize.getSize(6)),
      ),
      child: Text(
        type.toString().toCapitalized(),
        style: AppTextStyle.baseTextStyle(
          fontWeightType: FontWeightType.bold,
          fontSize: fromFilter ? AppSize.getTextSize(16) : AppSize.getTextSize(14),
          color: _getPokemonTypeColor()['font'],
        ),
      ),
    );
  }

  Map<String, Color> _getPokemonTypeColor() {
    switch (type.toLowerCase()) {
      case 'normal':
        return {
          'background': const Color(0xFFA8A77A),
          'font': Colors.white,
        };
      case 'fire':
        return {
          'background': const Color(0xFFEE8130),
          'font': Colors.white,
        };
      case 'water':
        return {
          'background': const Color(0xFF6390F0),
          'font': Colors.white,
        };
      case 'electric':
        return {
          'background': const Color(0xFFF7D02C),
          'font': Colors.black,
        };
      case 'grass':
        return {
          'background': const Color(0xFF7AC74C),
          'font': Colors.black,
        };
      case 'ice':
        return {
          'background': const Color(0xFF96D9D6),
          'font': Colors.black,
        };
      case 'fighting':
        return {
          'background': const Color(0xFFC22E28),
          'font': Colors.white,
        };
      case 'poison':
        return {
          'background': const Color(0xFFA33EA1),
          'font': Colors.white,
        };
      case 'ground':
        return {
          'background': const Color(0xFFE2BF65),
          'font': Colors.black,
        };
      case 'flying':
        return {
          'background': const Color(0xFF87CEEB),
          'font': Colors.black,
        };
      case 'psychic':
        return {
          'background': const Color(0xFFF95587),
          'font': Colors.white,
        };
      case 'bug':
        return {
          'background': const Color(0xFFA6B91A),
          'font': Colors.black,
        };
      case 'rock':
        return {
          'background': const Color(0xFFB6A136),
          'font': Colors.black,
        };
      case 'ghost':
        return {
          'background': const Color(0xFF735797),
          'font': Colors.white,
        };
      case 'dragon':
        return {
          'background': const Color(0xFF6F35FC),
          'font': Colors.white,
        };
      case 'dark':
        return {
          'background': const Color(0xFF705746),
          'font': Colors.white,
        };
      case 'steel':
        return {
          'background': const Color(0xFFB7B7CE),
          'font': Colors.black,
        };
      case 'fairy':
        return {
          'background': const Color(0xFFD685AD),
          'font': Colors.black,
        };
      default:
        return {
          'background': Colors.grey,
          'font': Colors.black,
        };
    }
  }
}
