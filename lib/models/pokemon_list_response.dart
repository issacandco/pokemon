import 'base_info.dart';

class PokemonListResponse {
  int? count;
  String? next;
  String? previous;
  List<BaseInfo>? results;

  PokemonListResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>?)?.map((item) => BaseInfo.fromJson(item)).toList(),
    );
  }
}
