import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speed_run/domain/services/models/asset.dart';
import 'package:speed_run/domain/services/models/names.dart';
import 'package:speed_run/domain/services/models/platform.dart';

part 'game.freezed.dart';

@freezed
abstract class Game with _$Game {
  const Game._();

  const factory Game(
      {String id,
      Names names,
      String abbreviation,
      String released,
      Asset coverMedium,
      Asset coverLarge,
      Asset background,
      List<Platform> platforms}) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) {
    var platforms = List<Platform>();
    if (!(json["platforms"] is List) && json["platforms"]["data"] != null) {
      platforms = (json["platforms"]["data"] as List)
          .map((model) => Platform.fromJson(model as Map<String, dynamic>))
          .toList();
    }

    return Game(
        id: json["id"].toString(),
        names: Names.fromJson(json["names"] as Map<String, dynamic>),
        abbreviation: json["abbreviation"].toString(),
        released: json["released"].toString(),
        coverMedium: Asset.fromJson(
            json["assets"]["cover-medium"] as Map<String, dynamic>),
        coverLarge: Asset.fromJson(
            json["assets"]["cover-large"] as Map<String, dynamic>),
        background: json["assets"]["background"] != null
            ? Asset.fromJson(
                json["assets"]["background"] as Map<String, dynamic>)
            : null,
        platforms: platforms);
  }

  String get platformsAvaible {
    return platforms?.map((e) => e.name).toList().join(", ");
  }

  String get name {
    return names?.international ?? "";
  }
}
