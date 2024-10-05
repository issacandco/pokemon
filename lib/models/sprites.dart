import 'other_sprites.dart';

class Sprites {
  String? frontDefault;
  String? frontShiny;
  OtherSprites? other;

  Sprites({this.frontDefault, this.frontShiny, this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
      other: json['other'] != null ? OtherSprites.fromJson(json['other']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'front_shiny': frontShiny,
      'other': other?.toJson(),
    };
  }
}