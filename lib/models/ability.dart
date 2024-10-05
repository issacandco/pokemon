import 'base_info.dart';

class Ability {
  bool? isHidden;
  int? slot;
  BaseInfo? ability;

  Ability({this.isHidden, this.slot, this.ability});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      isHidden: json['is_hidden'],
      slot: json['slot'],
      ability: BaseInfo.fromJson(json['ability']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_hidden': isHidden,
      'slot': slot,
      'ability': ability?.toJson(),
    };
  }
}
