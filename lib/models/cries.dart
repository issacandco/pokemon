class Cries {
  String? latest;
  String? legacy;

  Cries({this.latest, this.legacy});

  factory Cries.fromJson(Map<String, dynamic> json) {
    return Cries(
      latest: json['latest'],
      legacy: json['legacy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest': latest,
      'legacy': legacy,
    };
  }
}
