import 'base_info.dart';

class PokemonByType {
  int? slot;
  BaseInfo? pokemon;

  PokemonByType({this.slot, this.pokemon});

  factory PokemonByType.fromJson(Map<String, dynamic> json) {
    return PokemonByType(
      slot: json['slot'],
      pokemon: BaseInfo.fromJson(json['pokemon']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': slot,
      'pokemon': pokemon?.toJson(),
    };
  }
}
