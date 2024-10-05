class Home {
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  Home({this.frontDefault, this.frontFemale, this.frontShiny, this.frontShinyFemale});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'front_female': frontFemale,
      'front_shiny': frontShiny,
      'front_shiny_female': frontShinyFemale,
    };
  }
}