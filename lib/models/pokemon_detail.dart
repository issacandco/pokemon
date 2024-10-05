import 'ability.dart';
import 'cries.dart';
import 'pokemon_type.dart';
import 'sprites.dart';
import 'stat.dart';

class PokemonDetail {
  int? id;
  String? name;
  int? baseExperience;
  int? height;
  int? weight;
  int? order;
  List<PokemonType>? types;
  List<Ability>? abilities;
  Sprites? sprites;
  Cries? cries;
  List<Stat>? stats;

  String? gender;
  bool? shiny;
  DateTime? caughtTime;

  PokemonDetail({
    this.id,
    this.name,
    this.baseExperience,
    this.height,
    this.weight,
    this.types,
    this.abilities,
    this.sprites,
    this.cries,
    this.stats,
    this.gender,
    this.shiny,
    this.caughtTime,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List<dynamic>?)?.map((item) => PokemonType.fromJson(item)).toList(),
      abilities: (json['abilities'] as List<dynamic>?)?.map((item) => Ability.fromJson(item)).toList(),
      sprites: json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null,
      cries: json['cries'] != null ? Cries.fromJson(json['cries']) : null,
      stats: (json['stats'] as List<dynamic>?)?.map((item) => Stat.fromJson(item)).toList(),
      gender: json['gender'],
      shiny: json['shiny'],
      caughtTime: json['caught_time'] != null ? DateTime.parse(json['caught_time'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'base_experience': baseExperience,
      'height': height,
      'weight': weight,
      'types': types?.map((type) => type.toJson()).toList(),
      'abilities': abilities?.map((ability) => ability.toJson()).toList(),
      'sprites': sprites?.toJson(),
      'cries': cries?.toJson(),
      'stats': stats?.map((stat) => stat.toJson()).toList(),
      'gender': gender,
      'shiny': shiny,
      'caught_time': caughtTime?.toIso8601String(),
    };
  }
}
