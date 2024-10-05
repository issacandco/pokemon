enum Flavor {
  development,
  staging,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Pokémon Development';
      case Flavor.staging:
        return 'Pokémon Staging';
      case Flavor.production:
        return 'Pokémon';
      default:
        return 'title';
    }
  }

  static String get apiBaseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return 'https://pokeapi.co/api';
      case Flavor.staging:
        return 'https://pokeapi.co/api';
      case Flavor.production:
      default:
        return 'https://pokeapi.co/api';
    }
  }
}
