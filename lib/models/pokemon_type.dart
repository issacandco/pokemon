import 'base_info.dart';

class PokemonType {
  int? slot;
  BaseInfo? type;

  PokemonType({this.slot, this.type});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      slot: json['slot'],
      type: BaseInfo.fromJson(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'type': type?.toJson(),
    };
  }
}
