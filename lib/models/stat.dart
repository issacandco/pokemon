import 'base_info.dart';

class Stat {
  final int? baseStat;
  final int? effort;
  final BaseInfo? stat;

  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat'],
      effort: json['effort'],
      stat: BaseInfo.fromJson(json['stat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat?.toJson(),
    };
  }
}
