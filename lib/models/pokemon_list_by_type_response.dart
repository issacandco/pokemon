import 'pokemon_by_type.dart';

class PokemonListByTypeResponse {
  List<PokemonByType>? pokemon;

  PokemonListByTypeResponse({
    this.pokemon,
  });

  factory PokemonListByTypeResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListByTypeResponse(
      pokemon: (json['pokemon'] as List<dynamic>?)?.map((item) => PokemonByType.fromJson(item)).toList(),
    );
  }
}
