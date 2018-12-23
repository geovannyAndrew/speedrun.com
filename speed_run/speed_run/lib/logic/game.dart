

import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/logic/names.dart';

class Game{
  final String id;
  final Names names;
  final String abbreviation;
  final String released;
  final Asset coverMedium;
  final Asset coverLarge;

  Game(
      this.id,
      this.names,
      this.abbreviation,
      this.released,
      this.coverMedium,
      this.coverLarge
      );

  factory Game.fromJson(Map<String, dynamic> json){
    return Game(
        json["id"].toString(),
        Names.fromJson(json["names"]),
        json["abbreviation"].toString(),
        json["released"].toString(),
        Asset.fromJson(json["assets"]["cover-medium"]),
        Asset.fromJson(json["assets"]["cover-large"])
    );
  }
}