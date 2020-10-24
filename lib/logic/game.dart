import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/logic/platform.dart';

class Game{
  final String id;
  final Names names;
  final String abbreviation;
  final String released;
  final Asset coverMedium;
  final Asset coverLarge;
  final Asset background;
  final List<Platform> platforms;

  Game(
      this.id,
      this.names,
      this.abbreviation,
      this.released,
      this.coverMedium,
      this.coverLarge,
      this.background,
      this.platforms
      );

  factory Game.fromJson(Map<String, dynamic> json){
    var platforms = List<Platform>();
    if(!(json["platforms"] is List) && json["platforms"]["data"]!=null){
      platforms = (json["platforms"]["data"] as List).map((model)=> Platform.fromJson(model)).toList();
    }

    return Game(
        json["id"].toString(),
        Names.fromJson(json["names"]),
        json["abbreviation"].toString(),
        json["released"].toString(),
        Asset.fromJson(json["assets"]["cover-medium"]),
        Asset.fromJson(json["assets"]["cover-large"]),
        json["assets"]["background"] != null ? Asset.fromJson(json["assets"]["background"]) : null,
        platforms
    );
  }

  String get platformsAvaible{
    var plats = "";
    platforms?.forEach((platform){
        if(plats.isNotEmpty){
          plats+=", ";
        }
        plats+=platform.name;}
    );
    return plats;
  }

  String get name{
    return names?.international ?? "";
  }
}