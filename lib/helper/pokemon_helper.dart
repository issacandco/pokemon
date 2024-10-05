import '../constants/constants.dart';
import '../models/pokemon_detail.dart';
import '../utils/get_storage_util.dart';

class PokemonHelper {
  /// Gets the list of owned Pokémon stored in GetStorage.
  static List<PokemonDetail> getOwnedPokemonList() {
    List<dynamic> rawList = GetStorageUtil.readFromGetStorage(key: Constants.keyOwned) ?? [];
    return rawList.map((data) => PokemonDetail.fromJson(data)).toList();
  }

  /// Add owned Pokémon list to GetStorage.
  static void addToOwnedPokemon(PokemonDetail pokemon) {
    List<PokemonDetail> ownedList = getOwnedPokemonList();
    pokemon.caughtTime = DateTime.now();
    ownedList.add(pokemon);
    _saveOwnedList(ownedList);
  }

  static void removeFromOwnedPokemon(PokemonDetail pokemonDetail) {
    List<PokemonDetail> ownedPokemonList = getOwnedPokemonList();

    ownedPokemonList.removeWhere((pokemon) => pokemon.id == pokemonDetail.id && pokemon.caughtTime == pokemonDetail.caughtTime);
    _saveOwnedList(ownedPokemonList);

    increaseReleasedCount();
  }

  /// Saves the updated owned Pokémon list to GetStorage.
  static void _saveOwnedList(List<PokemonDetail> ownedList) {
    List<Map<String, dynamic>> rawList = ownedList.map((pokemon) => pokemon.toJson()).toList();
    GetStorageUtil.saveIntoGetStorage(key: Constants.keyOwned, value: rawList);
  }

  /// Gets the count of owned Pokémon.
  static int getOwnedCount() {
    return getOwnedPokemonList().length;
  }

  static void increaseFleeCount() {
    int currentCount = getFleeCount();
    GetStorageUtil.saveIntoGetStorage(key: Constants.keyFlee, value: currentCount + 1);
  }

  static int getFleeCount() {
    return GetStorageUtil.readFromGetStorage(key: Constants.keyFlee) ?? 0;
  }

  static void increaseReleasedCount() {
    int currentCount = getReleasedCount();
    GetStorageUtil.saveIntoGetStorage(key: Constants.keyReleased, value: currentCount + 1);
  }

  static int getReleasedCount() {
    return GetStorageUtil.readFromGetStorage(key: Constants.keyReleased) ?? 0;
  }

  /// Gets the list of favorite Pokémon stored in GetStorage.
  static List<PokemonDetail> getFavouritePokemonList() {
    List<dynamic> rawList = GetStorageUtil.readFromGetStorage(key: Constants.keyFavourite) ?? [];
    return rawList.map((data) => PokemonDetail.fromJson(data)).toList();
  }

  /// Checks if a Pokémon is a favorite by its ID.
  static bool checkIsFavouriteByPokemonId(int pokemonId) {
    List<PokemonDetail> favouriteList = getFavouritePokemonList();
    return favouriteList.any((pokemon) => pokemon.id == pokemonId);
  }

  /// Adds a Pokémon to the favorites list and updates storage.
  static void addToFavourite(PokemonDetail pokemon) {
    List<PokemonDetail> favouriteList = getFavouritePokemonList();

    if (!favouriteList.any((p) => p.id == pokemon.id)) {
      favouriteList.add(pokemon);
      _saveFavouriteList(favouriteList);
    }
  }

  /// Removes a Pokémon from the favorites list using its ID and updates storage.
  static void removeFromFavourite(int pokemonId) {
    List<PokemonDetail> favouriteList = getFavouritePokemonList();

    favouriteList.removeWhere((pokemon) => pokemon.id == pokemonId);
    _saveFavouriteList(favouriteList);
  }

  /// Saves the updated favorite Pokémon list to GetStorage.
  static void _saveFavouriteList(List<PokemonDetail> favouriteList) {
    List<Map<String, dynamic>> rawList = favouriteList.map((pokemon) => pokemon.toJson()).toList();
    GetStorageUtil.saveIntoGetStorage(key: Constants.keyFavourite, value: rawList);
  }
}
