import 'home.dart';
import 'official_artwork.dart';
import 'showdown.dart';

class OtherSprites {
  Home? home;
  OfficialArtwork? officialArtwork;
  Showdown? showdown;

  OtherSprites({
    this.home,
    this.officialArtwork,
    this.showdown,
  });

  factory OtherSprites.fromJson(Map<String, dynamic> json) {
    return OtherSprites(
      home: json['home'] != null ? Home.fromJson(json['home']) : null,
      officialArtwork: json['official-artwork'] != null ? OfficialArtwork.fromJson(json['official-artwork']) : null,
      showdown: json['showdown'] != null ? Showdown.fromJson(json['showdown']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'home': home?.toJson(),
      'official-artwork': officialArtwork?.toJson(),
      'showdown': showdown?.toJson(),
    };
  }
}
