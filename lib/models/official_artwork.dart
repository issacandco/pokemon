class OfficialArtwork {
  String? frontDefault;
  String? frontShiny;

  OfficialArtwork({this.frontDefault, this.frontShiny});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'front_shiny': frontShiny,
    };
  }
}